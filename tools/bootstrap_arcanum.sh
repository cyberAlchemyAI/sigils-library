#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: tools/bootstrap_arcanum.sh [options]

Install Arcanum into a consuming repository.

Options:
  --target <path>       Target repository root. Default: current directory.
  --prefix <path>       Install prefix inside target. Default: .arcanum.
  --sigils <list|all>   Comma-separated sigil IDs or all commands. Default: all.
  --spells <list|all|none>
                        Comma-separated spell command IDs, all, or none. Default: all.
  --runtime <target>    Runtime adapter: github-copilot, claude, codex, none. Default: none.
  --command <name>      Runtime command name. Default: arcanum-orchestrate.
  --force               Overwrite existing installed Arcanum files.
  --dry-run             Print planned actions without writing files.
  -h, --help            Show this help.

Examples:
  tools/bootstrap_arcanum.sh --target ../my-repo --sigils all --runtime github-copilot
  tools/bootstrap_arcanum.sh --target ../my-repo --sigils ontology-vault,context-builder --spells ontology-harness --runtime github-copilot
USAGE
}

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
arcanum_root="$(cd "$script_dir/.." && pwd)"
target_root="$PWD"
install_prefix=".arcanum"
sigil_selection="all"
spell_selection="all"
runtime="none"
command_name="arcanum-orchestrate"
force="false"
dry_run="false"
installed_sigil_ids=()
installed_sigil_tiers=()
installed_spell_ids=()

titleize_id() {
  printf '%s' "$1" | tr '-' ' '
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      target_root="$2"
      shift 2
      ;;
    --prefix)
      install_prefix="$2"
      shift 2
      ;;
    --sigils)
      sigil_selection="$2"
      shift 2
      ;;
    --spells)
      spell_selection="$2"
      shift 2
      ;;
    --runtime)
      runtime="$2"
      shift 2
      ;;
    --command)
      command_name="$2"
      shift 2
      ;;
    --force)
      force="true"
      shift
      ;;
    --dry-run)
      dry_run="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

case "$runtime" in
  github-copilot|claude|codex|none) ;;
  *)
    echo "Unsupported runtime: $runtime" >&2
    exit 2
    ;;
esac

target_root="$(mkdir -p "$target_root" && cd "$target_root" && pwd)"
dest_root="$target_root/$install_prefix"
arcanum_repo_url="https://github.com/cyberAlchemyAI/arcanum"

run() {
  if [[ "$dry_run" == "true" ]]; then
    printf '[dry-run] %q' "$1"
    shift || true
    for arg in "$@"; do
      printf ' %q' "$arg"
    done
    printf '\n'
  else
    "$@"
  fi
}

ensure_clean_destination() {
  local path="$1"
  if [[ -e "$path" && "$force" != "true" ]]; then
    echo "Refusing to overwrite existing path without --force: $path" >&2
    exit 1
  fi
}

copy_path() {
  local src="$1"
  local dst="$2"
  ensure_clean_destination "$dst"
  run mkdir -p "$(dirname "$dst")"
  if [[ "$dry_run" == "true" ]]; then
    echo "[dry-run] copy $src -> $dst"
  else
    rm -rf "$dst"
    cp -R "$src" "$dst"
  fi
}

write_file_if_missing() {
  local dst="$1"
  local content="$2"
  if [[ -e "$dst" ]]; then
    return 0
  fi
  run mkdir -p "$(dirname "$dst")"
  if [[ "$dry_run" == "true" ]]; then
    echo "[dry-run] write $dst"
  else
    printf '%s\n' "$content" > "$dst"
  fi
}

touch_file_if_missing() {
  local dst="$1"
  if [[ -e "$dst" ]]; then
    return 0
  fi
  run mkdir -p "$(dirname "$dst")"
  if [[ "$dry_run" == "true" ]]; then
    echo "[dry-run] touch $dst"
  else
    : > "$dst"
  fi
}

install_observability_package() {
  local observability_root="$dest_root/observability"

  run mkdir -p \
    "$observability_root/signals" \
    "$observability_root/by-sigil" \
    "$observability_root/reflections"

  write_file_if_missing "$observability_root/README.md" "# Arcanum Observability

This repository-local package stores Arcanum runtime command, sigil, and spell telemetry plus reflection state.

- signals/sigil-invocations.jsonl is the central append-only invocation ledger.
- by-sigil/ can hold optional per-artifact ledgers.
- reflections/ can hold future reflection reports."

  write_file_if_missing "$observability_root/config.json" '{
  "version": "0.1.0",
  "storage_model": "hybrid",
  "source_of_truth": "signals/sigil-invocations.jsonl",
  "per_sigil_path": "by-sigil/<sigil-name>.jsonl",
  "reflection_path": "reflections/",
  "thresholds": {
    "meaningful_executions": 5,
    "generated_outputs": 10,
    "related_workflow_gaps": 3,
    "severe_workflow_gaps": 1
  }
}'

  write_file_if_missing "$observability_root/reflection-state.json" '{
  "version": "0.1.0",
  "last_reflection_at": null,
  "counters": {
    "meaningful_executions": 0,
    "generated_outputs": 0,
    "related_workflow_gaps": 0,
    "severe_workflow_gaps": 0,
    "quality_bar_failures": 0,
    "output_contract_drift_events": 0
  },
  "by_sigil": {}
}'

  touch_file_if_missing "$observability_root/signals/sigil-invocations.jsonl"
  touch_file_if_missing "$observability_root/by-sigil/.gitkeep"
  touch_file_if_missing "$observability_root/reflections/.gitkeep"
}

sigil_path_for() {
  local sigil="$1"
  local tier
  for tier in formulae transmutations arcana; do
    if [[ -d "$arcanum_root/$tier/$sigil" ]]; then
      printf '%s/%s' "$tier" "$sigil"
      return 0
    fi
  done
  return 1
}

collect_selected_sigils() {
  local selection="$1"
  local sigil tier_path tier sigil_name
  if [[ "$selection" == "all" ]]; then
    for tier in formulae transmutations arcana; do
      while IFS= read -r tier_path; do
        sigil_name="$(basename "$tier_path")"
        [[ -f "$tier_path/SKILL.md" ]] || continue
        installed_sigil_ids+=("$sigil_name")
        installed_sigil_tiers+=("$tier")
      done < <(find "$arcanum_root/$tier" -mindepth 1 -maxdepth 1 -type d | sort)
    done
    return 0
  fi

  IFS=',' read -ra sigils <<< "$selection"
  for sigil in "${sigils[@]}"; do
    sigil="${sigil//[[:space:]]/}"
    [[ -n "$sigil" ]] || continue
    if ! tier_path="$(sigil_path_for "$sigil")"; then
      echo "Unknown sigil: $sigil" >&2
      exit 1
    fi
    installed_sigil_ids+=("$sigil")
    installed_sigil_tiers+=("${tier_path%%/*}")
  done
}

collect_selected_spells() {
  local selection="$1"
  local spell spell_file
  if [[ "$selection" == "none" ]]; then
    return 0
  fi
  if [[ "$selection" == "all" ]]; then
    while IFS= read -r spell_file; do
      installed_spell_ids+=("$(basename "$spell_file" .md)")
    done < <(find "$arcanum_root/spells" -maxdepth 1 -type f -name '*.md' ! -name 'README.md' | sort)
    return 0
  fi

  IFS=',' read -ra spells <<< "$selection"
  for spell in "${spells[@]}"; do
    spell="${spell//[[:space:]]/}"
    [[ -n "$spell" ]] || continue
    spell_file="$arcanum_root/spells/$spell.md"
    if [[ ! -f "$spell_file" ]]; then
      echo "Unknown spell: $spell" >&2
      exit 1
    fi
    installed_spell_ids+=("$spell")
  done
}

append_file_as_fenced_block() {
  local source_file="$1"
  local target_file="$2"
  local label="$3"
  local source_url="$4"

  {
    printf '\n## %s\n\n' "$label"
    printf 'Canonical source: %s\n\n' "$source_url"
    printf '````markdown\n'
    cat "$source_file"
    printf '\n````\n'
  } >> "$target_file"
}

append_sigil_snapshot() {
  local sigil="$1"
  local tier="$2"
  local target_file="$3"
  local sigil_root="$arcanum_root/$tier/$sigil"
  if [[ -f "$sigil_root/README.md" ]]; then
    append_file_as_fenced_block "$sigil_root/README.md" "$target_file" "Canonical README Snapshot" "$arcanum_repo_url/blob/main/$tier/$sigil/README.md"
  fi
  append_file_as_fenced_block "$sigil_root/SKILL.md" "$target_file" "Canonical SKILL Snapshot" "$arcanum_repo_url/blob/main/$tier/$sigil/SKILL.md"
}

append_spell_snapshot() {
  local spell="$1"
  local target_file="$2"
  append_file_as_fenced_block "$arcanum_root/spells/$spell.md" "$target_file" "Canonical Spell Snapshot" "$arcanum_repo_url/blob/main/spells/$spell.md"
}

write_github_copilot_adapter() {
  local adapter="$dest_root/runtimes/github-copilot/skills/$command_name/SKILL.md"
  local bridge="$target_root/.github/skills/$command_name/SKILL.md"
  ensure_clean_destination "$adapter"
  ensure_clean_destination "$bridge"
  run mkdir -p "$(dirname "$adapter")"
  run mkdir -p "$(dirname "$bridge")"
  if [[ "$dry_run" == "true" ]]; then
    echo "[dry-run] write GitHub Copilot adapter $adapter"
    echo "[dry-run] write GitHub Copilot discovery bridge $bridge"
    return 0
  fi
  cat > "$adapter" <<EOF_ADAPTER
---
name: $command_name
description: Route Arcanum requests through installed slash commands and ontology harness aliases.
argument-hint: "<natural-language-arcanum-request>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum Orchestrate

<objective>
Route a user request to the installed Arcanum slash-command surface. Treat Necronomicon as the Ontology Harness alias, not as a generated runtime registry folder.
</objective>

<context>
Arcanum runtime support is installed at $install_prefix/ in this repository. Runtime commands live under $install_prefix/runtimes/ and may be exposed through repository-specific discovery bridges. Observability state lives under $install_prefix/observability/.
</context>

<process>
1. Classify the request as Necronomicon/Ontology Harness, sigil usage, spell usage, install/setup, authoring, validation, observability, or help.
2. Route Necronomicon, ontology, vault, premise, session distillation, business/system branch, or bridge-validation requests to the Ontology Harness command.
3. Route explicit sigil or spell requests to the matching installed arcanum-sigil-<id> or arcanum-spell-<id> command.
4. If multiple routes are plausible, ask one focused clarification.
5. Read the selected installed command adapter and follow its embedded canonical definition snapshot.
6. Apply the observability handoff by summarizing request, route, files changed, validation, gaps, and follow-up; append telemetry under $install_prefix/observability/ when allowed.
7. Return the selected route, command used, validation result, observability result, and next action.
</process>

<guardrails>
- Keep this skill as a thin runtime adapter.
- Do not require or create $install_prefix/necronomicon/ runtime registry files.
- Necronomicon means the Ontology Harness alias.
- Use installed slash commands as the local execution surface.
</guardrails>
EOF_ADAPTER

  {
    printf '\n## Installed Command Surface\n\n'
    printf -- '- `%s`: general Arcanum router.\n' "$command_name"
    if printf '%s\n' "${installed_spell_ids[@]}" | grep -qx 'ontology-harness'; then
      printf -- '- `arcanum-necronomicon`: alias for `arcanum-spell-ontology-harness`.\n'
    fi
    local index sigil spell
    for index in "${!installed_sigil_ids[@]}"; do
      sigil="${installed_sigil_ids[$index]}"
      printf -- '- `arcanum-sigil-%s`\n' "$sigil"
    done
    for spell in "${installed_spell_ids[@]}"; do
      printf -- '- `arcanum-spell-%s`\n' "$spell"
    done
  } >> "$adapter"

  cat > "$bridge" <<EOF_BRIDGE
---
name: $command_name
description: Route Arcanum requests through the installed local Arcanum runtime adapter.
argument-hint: "<natural-language-arcanum-request>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum Orchestrate

<objective>
Expose the installed Arcanum GitHub Copilot adapter to GitHub Copilot's required discovery path.
</objective>

<context>
The canonical local adapter lives at $install_prefix/runtimes/github-copilot/skills/$command_name/SKILL.md.
</context>

<process>
1. Read $install_prefix/runtimes/github-copilot/skills/$command_name/SKILL.md.
2. Follow that adapter's process.
3. If the runtime adapter is unavailable, report a blocked install and ask to rerun Arcanum bootstrap.
</process>

<guardrails>
- Keep this file as a discovery bridge only.
- Do not copy full sigil internals into this wrapper.
- Treat $install_prefix/runtimes/github-copilot/ as authoritative for installed runtime behavior.
</guardrails>
EOF_BRIDGE
}

write_github_copilot_artifact_adapter() {
  local artifact_kind="$1"
  local artifact_id="$2"
  local artifact_tier="$3"
  local definition_path="$4"
  local runtime_command="arcanum-$artifact_kind-$artifact_id"
  if [[ "$artifact_kind" == "necronomicon" ]]; then
    runtime_command="arcanum-necronomicon"
  fi
  local adapter="$dest_root/runtimes/github-copilot/skills/$runtime_command/SKILL.md"
  local bridge="$target_root/.github/skills/$runtime_command/SKILL.md"
  local display_kind display_title
  display_kind="$(titleize_id "$artifact_kind")"
  display_title="$(titleize_id "$artifact_id")"

  ensure_clean_destination "$adapter"
  ensure_clean_destination "$bridge"
  run mkdir -p "$(dirname "$adapter")"
  run mkdir -p "$(dirname "$bridge")"
  if [[ "$dry_run" == "true" ]]; then
    echo "[dry-run] write GitHub Copilot $artifact_kind adapter $adapter"
    echo "[dry-run] write GitHub Copilot $artifact_kind discovery bridge $bridge"
    return 0
  fi

  cat > "$adapter" <<EOF_ADAPTER
---
name: $runtime_command
description: Run the installed Arcanum $artifact_kind $artifact_id from its embedded canonical definition snapshot.
argument-hint: "<request-for-$artifact_id>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum $display_kind: $display_title

<objective>
Run the installed Arcanum $artifact_kind $artifact_id using the canonical definition snapshot embedded in this slash command.
</objective>

<context>
Arcanum runtime support is installed at $install_prefix/ in this repository. Necronomicon is the Ontology Harness alias, not a generated runtime registry folder. The canonical source reference for this command is $definition_path.
</context>

<process>
1. Use the embedded canonical definition snapshot below as the execution contract.
2. For sigils, use both the README and SKILL snapshots when present. For spells, follow the spell snapshot directly.
3. Execute only this installed $artifact_kind unless the definition explicitly delegates or the user asks to route elsewhere.
4. Preserve the selected artifact's process, quality bar, anti-patterns, output contract, and validation gates.
5. Apply the observability handoff by summarizing request, artifact, outputs, files changed, validation, gaps, and follow-up; append telemetry under $install_prefix/observability/ when allowed.
6. Return the artifact used, command used, validation result, observability result, and next action.
</process>

<guardrails>
- Keep this skill as a thin runtime adapter for one installed artifact.
- Do not require or create $install_prefix/necronomicon/ runtime registry files.
- Necronomicon means the Ontology Harness alias.
- Treat the embedded canonical snapshot as the local command contract.
</guardrails>
EOF_ADAPTER

  if [[ "$artifact_kind" == "sigil" ]]; then
    append_sigil_snapshot "$artifact_id" "$artifact_tier" "$adapter"
  else
    append_spell_snapshot "$artifact_id" "$adapter"
  fi

  cat > "$bridge" <<EOF_BRIDGE
---
name: $runtime_command
description: Run the installed Arcanum $artifact_kind $artifact_id through its local runtime adapter.
argument-hint: "<request-for-$artifact_id>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum $display_kind: $display_title

<objective>
Expose the installed Arcanum $artifact_kind adapter to GitHub Copilot's required discovery path.
</objective>

<context>
The canonical local adapter lives at $install_prefix/runtimes/github-copilot/skills/$runtime_command/SKILL.md.
</context>

<process>
1. Read $install_prefix/runtimes/github-copilot/skills/$runtime_command/SKILL.md.
2. Follow that adapter's process.
3. If the runtime adapter is unavailable, report a blocked install and ask to rerun Arcanum bootstrap.
</process>

<guardrails>
- Keep this file as a discovery bridge only.
- Do not copy full artifact internals into this wrapper.
</guardrails>
EOF_BRIDGE
}

write_command_adapter_plan() {
  local runtime_dir="$1"
  local runtime_name="${runtime_dir#.}"
  local adapter="$dest_root/runtimes/$runtime_name/commands/$command_name.md"
  local bridge="$target_root/$runtime_dir/commands/$command_name.md"
  ensure_clean_destination "$adapter"
  ensure_clean_destination "$bridge"
  run mkdir -p "$(dirname "$adapter")"
  run mkdir -p "$(dirname "$bridge")"
  if [[ "$dry_run" == "true" ]]; then
    echo "[dry-run] write command adapter plan $adapter"
    echo "[dry-run] write command adapter discovery bridge $bridge"
    return 0
  fi
  cat > "$adapter" <<EOF_ADAPTER
# Arcanum Orchestrate

Arcanum is installed at $install_prefix/ in this repository.

  Route requests through installed slash commands under:

  - $install_prefix/runtimes/$runtime_name/commands/

  Necronomicon means the Ontology Harness alias. Route Necronomicon, ontology, vault, premise, session distillation, branch mapping, or business-system bridge requests to the Ontology Harness command.

  Apply observability by summarizing route, outputs, files changed, validation, gaps, and follow-up; append telemetry under $install_prefix/observability/ when allowed.
EOF_ADAPTER

    {
      printf '\n## Installed Command Surface\n\n'
      printf -- '- `%s`: general Arcanum router.\n' "$command_name"
      if printf '%s\n' "${installed_spell_ids[@]}" | grep -qx 'ontology-harness'; then
        printf -- '- `arcanum-necronomicon`: alias for `arcanum-spell-ontology-harness`.\n'
      fi
      local index sigil spell
      for index in "${!installed_sigil_ids[@]}"; do
        sigil="${installed_sigil_ids[$index]}"
        printf -- '- `arcanum-sigil-%s`\n' "$sigil"
      done
      for spell in "${installed_spell_ids[@]}"; do
        printf -- '- `arcanum-spell-%s`\n' "$spell"
      done
    } >> "$adapter"

  cat > "$bridge" <<EOF_BRIDGE
# Arcanum Orchestrate

Use the installed Arcanum runtime adapter at:

- $install_prefix/runtimes/$runtime_name/commands/$command_name.md

Keep this command adapter bridge thin.
EOF_BRIDGE
}

write_command_artifact_adapter() {
  local runtime_dir="$1"
  local artifact_kind="$2"
  local artifact_id="$3"
  local artifact_tier="$4"
  local definition_path="$5"
  local runtime_name="${runtime_dir#.}"
  local runtime_command="arcanum-$artifact_kind-$artifact_id"
  if [[ "$artifact_kind" == "necronomicon" ]]; then
    runtime_command="arcanum-necronomicon"
  fi
  local adapter="$dest_root/runtimes/$runtime_name/commands/$runtime_command.md"
  local bridge="$target_root/$runtime_dir/commands/$runtime_command.md"
  local display_kind display_title
  display_kind="$(titleize_id "$artifact_kind")"
  display_title="$(titleize_id "$artifact_id")"

  ensure_clean_destination "$adapter"
  ensure_clean_destination "$bridge"
  run mkdir -p "$(dirname "$adapter")"
  run mkdir -p "$(dirname "$bridge")"
  if [[ "$dry_run" == "true" ]]; then
    echo "[dry-run] write $runtime_name $artifact_kind command adapter $adapter"
    echo "[dry-run] write $runtime_name $artifact_kind discovery bridge $bridge"
    return 0
  fi

  cat > "$adapter" <<EOF_ADAPTER
# Arcanum $display_kind: $display_title

Arcanum is installed at $install_prefix/ in this repository.

Use this installed $artifact_kind adapter for $artifact_id.

Necronomicon means the Ontology Harness alias, not a generated runtime registry folder.

Runtime process:

1. Use the embedded canonical definition snapshot below as the execution contract.
2. Execute only this installed $artifact_kind unless the definition explicitly delegates or the user asks to route elsewhere.
3. Apply observability by summarizing request, artifact, outputs, files changed, validation, gaps, and follow-up; append telemetry under $install_prefix/observability/ when allowed.
4. Report the artifact used, command used, validation result, observability result, and next action.

Keep this command adapter focused on one artifact.
EOF_ADAPTER

  if [[ "$artifact_kind" == "sigil" ]]; then
    append_sigil_snapshot "$artifact_id" "$artifact_tier" "$adapter"
  else
    append_spell_snapshot "$artifact_id" "$adapter"
  fi

  cat > "$bridge" <<EOF_BRIDGE
# Arcanum $display_kind: $display_title

Use the installed Arcanum runtime adapter at:

- $install_prefix/runtimes/$runtime_name/commands/$runtime_command.md

Keep this command adapter bridge thin.
EOF_BRIDGE
}

write_github_copilot_individual_adapters() {
  local index sigil tier definition_path spell
  for index in "${!installed_sigil_ids[@]}"; do
    sigil="${installed_sigil_ids[$index]}"
    tier="${installed_sigil_tiers[$index]}"
    definition_path="$arcanum_repo_url/blob/main/$tier/$sigil/SKILL.md"
    write_github_copilot_artifact_adapter "sigil" "$sigil" "$tier" "$definition_path"
  done

  for spell in "${installed_spell_ids[@]}"; do
    definition_path="$arcanum_repo_url/blob/main/spells/$spell.md"
    write_github_copilot_artifact_adapter "spell" "$spell" "spell" "$definition_path"
    if [[ "$spell" == "ontology-harness" ]]; then
      write_github_copilot_artifact_adapter "necronomicon" "ontology-harness" "spell" "$definition_path"
    fi
  done
}

write_command_individual_adapters() {
  local runtime_dir="$1"
  local index sigil tier definition_path spell
  for index in "${!installed_sigil_ids[@]}"; do
    sigil="${installed_sigil_ids[$index]}"
    tier="${installed_sigil_tiers[$index]}"
    definition_path="$arcanum_repo_url/blob/main/$tier/$sigil/SKILL.md"
    write_command_artifact_adapter "$runtime_dir" "sigil" "$sigil" "$tier" "$definition_path"
  done

  for spell in "${installed_spell_ids[@]}"; do
    definition_path="$arcanum_repo_url/blob/main/spells/$spell.md"
    write_command_artifact_adapter "$runtime_dir" "spell" "$spell" "spell" "$definition_path"
    if [[ "$spell" == "ontology-harness" ]]; then
      write_command_artifact_adapter "$runtime_dir" "necronomicon" "ontology-harness" "spell" "$definition_path"
    fi
  done
}

install_runtime_adapter() {
  case "$runtime" in
    github-copilot)
      write_github_copilot_adapter
      write_github_copilot_individual_adapters
      ;;
    claude)
      write_command_adapter_plan ".claude"
      write_command_individual_adapters ".claude"
      ;;
    codex)
      write_command_adapter_plan ".codex"
      write_command_individual_adapters ".codex"
      ;;
    none)
      ;;
  esac
}

echo "Installing Arcanum"
echo "  source:  $arcanum_root"
echo "  target:  $target_root"
echo "  prefix:  $install_prefix"
echo "  sigils:  $sigil_selection"
echo "  spells:  $spell_selection"
echo "  runtime: $runtime"

run mkdir -p "$dest_root"
if [[ "$force" == "true" ]]; then
  run rm -rf "$dest_root/source"
  run rm -rf "$dest_root/necronomicon"
elif [[ -e "$dest_root/necronomicon" ]]; then
  echo "Found obsolete $install_prefix/necronomicon runtime-book files. Re-run with --force to remove them after preserving any local outputs you still need." >&2
  exit 1
fi
install_observability_package

collect_selected_sigils "$sigil_selection"
collect_selected_spells "$spell_selection"
install_runtime_adapter

echo "Arcanum bootstrap complete."
echo "Observability package: $install_prefix/observability/"
if [[ "$runtime" != "none" ]]; then
  echo "Runtime adapter: $install_prefix/runtimes/$runtime / $command_name"
  if printf '%s\n' "${installed_spell_ids[@]}" | grep -qx 'ontology-harness'; then
    echo "Necronomicon command alias: arcanum-necronomicon"
  fi
fi