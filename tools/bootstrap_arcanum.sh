#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: tools/bootstrap_arcanum.sh [options]

Install Arcanum into a consuming repository.

Options:
  --target <path>       Target repository root. Default: current directory.
  --prefix <path>       Install prefix inside target. Default: .arcanum.
  --sigils <list|all>   Comma-separated sigil IDs or all. Default: all.
  --spells <list|all|none>
                        Comma-separated spell IDs, all, or none. Default: all.
  --runtime <target>    Runtime adapter: github-copilot, claude, codex, none. Default: none.
  --command <name>      Runtime command name. Default: arcanum-orchestrate.
  --force               Overwrite existing installed Arcanum files.
  --dry-run             Print planned actions without writing files.
  -h, --help            Show this help.

Examples:
  tools/bootstrap_arcanum.sh --target ../my-repo --sigils all --runtime github-copilot
  tools/bootstrap_arcanum.sh --target ../my-repo --sigils ontology-vault,context-builder --spells ontology-harness
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
necronomicon_root="$dest_root/necronomicon"
spell_install_root="$necronomicon_root/spells"

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

  write_file_if_missing "$observability_root/README.md" "# Sigil Observability

This repository-local package stores Arcanum sigil invocation telemetry and reflection state.

- signals/sigil-invocations.jsonl is the central append-only invocation ledger.
- by-sigil/ can hold optional per-sigil ledgers.
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

write_necronomicon() {
  run mkdir -p "$necronomicon_root"
  if [[ "$dry_run" == "true" ]]; then
    echo "[dry-run] write Necronomicon runtime registry under $necronomicon_root"
    return 0
  fi

  cat > "$necronomicon_root/README.md" <<'EOF_NECRONOMICON'
# Necronomicon

Necronomicon is the installed Arcanum runtime book for this repository.

It owns registry lookup, orchestration routing, alias resolution, observability handoff, and the installed sigil and spell definition files for this repository.

## Runtime Files

- [REGISTRY.md](REGISTRY.md) - installed sigils and spells with definition paths.
- [ROUTES.md](ROUTES.md) - orchestration process and route rules.
- [OBSERVABILITY.md](OBSERVABILITY.md) - telemetry ledger and post-run handoff rules.
- [manifest.json](manifest.json) - structured runtime metadata for adapters or tools.
EOF_NECRONOMICON

  cat > "$necronomicon_root/REGISTRY.md" <<'EOF_REGISTRY'
# Necronomicon Registry

This registry is generated by Arcanum bootstrap for this repository-local install.

Runtime adapters must use this file for installed artifact lookup. The definition paths point to files stored inside Necronomicon.

## Installed Sigils

| Sigil | Tier | Definition Path | Invocation Notes |
| ----- | ---- | ----------- | ---------------- |
EOF_REGISTRY

  local index sigil tier title
  for index in "${!installed_sigil_ids[@]}"; do
    sigil="${installed_sigil_ids[$index]}"
    tier="${installed_sigil_tiers[$index]}"
    title="$(titleize_id "$sigil")"
    printf '| %s | %s | [%s/%s/SKILL.md](%s/%s/SKILL.md) | Read README.md and SKILL.md before execution. |\n' "$title" "$tier" "$tier" "$sigil" "$tier" "$sigil" >> "$necronomicon_root/REGISTRY.md"
  done

  cat >> "$necronomicon_root/REGISTRY.md" <<'EOF_REGISTRY'

## Installed Spells

| Spell | Definition Path | Invocation Notes |
| ----- | ----------- | ---------------- |
EOF_REGISTRY

  local spell
  for spell in "${installed_spell_ids[@]}"; do
    title="$(titleize_id "$spell")"
    printf '| %s | [spells/%s.md](spells/%s.md) | Read spell file before execution. |\n' "$title" "$spell" "$spell" >> "$necronomicon_root/REGISTRY.md"
  done

  cat >> "$necronomicon_root/REGISTRY.md" <<'EOF_REGISTRY'

## Library Indexes

- [Sigil Registry](registry/SIGILS.md)
- [Spell Registry](registry/SPELLS.md)
- [Pack Registry](registry/PACKS.md)
EOF_REGISTRY

  cat > "$necronomicon_root/ROUTES.md" <<'EOF_ROUTES'
# Necronomicon Routes

## Purpose

Route user requests to installed Arcanum sigils or spells without making runtime adapters inspect library registries directly.

## Routing Process

1. Read [REGISTRY.md](REGISTRY.md).
2. Classify the request as sigil usage, spell usage, install/setup, authoring, validation, observability, or help.
3. Select one installed sigil or spell from the Necronomicon registry.
4. If multiple routes are plausible, ask one focused clarification.
5. Open the selected definition path from [REGISTRY.md](REGISTRY.md).
6. Follow the selected artifact's process, quality bar, anti-patterns, output contract, and validation gates.
7. Apply the observability handoff in [OBSERVABILITY.md](OBSERVABILITY.md) after meaningful execution.

## Route Hints

| Request Shape | Preferred Route |
| ------------- | --------------- |
| install Arcanum or runtime adapters | arcanum-bootstrap or sigil-runtime-installer |
| create, revise, observe, or reflect on sigils | sigil-development |
| convert a skill or workflow into a sigil | skill-transcriptor |
| decompose a broad source into sigil candidates | skill-decomposer |
| compose multiple sigils into a workflow | spellcraft |
| setup or verify telemetry | observability-setup |
| build compact task context | context-builder |
| map repository architecture | architecture-pattern-inventory |
| govern vault-like knowledge | ontology-vault or ontology-harness |
| repository knowledge harness | repository-harness |

## Guardrails

- Necronomicon is the runtime registry and orchestration layer.
- Files under formulae/, transmutations/, arcana/, and spells/ are installed definitions, not the runtime router.
- Runtime adapters should not bypass Necronomicon unless Necronomicon is missing or corrupted.
- Observability handoff belongs to Necronomicon, even though telemetry files live under ../observability/.
EOF_ROUTES

  cat > "$necronomicon_root/OBSERVABILITY.md" <<'EOF_OBSERVABILITY'
# Necronomicon Observability

Necronomicon owns the post-run observability handoff for installed Arcanum runtime usage.

## Ledger

- Central invocation ledger: [../observability/signals/sigil-invocations.jsonl](../observability/signals/sigil-invocations.jsonl)
- Reflection state: [../observability/reflection-state.json](../observability/reflection-state.json)
- Optional per-sigil ledgers: ../observability/by-sigil/
- Reflection reports: ../observability/reflections/

## Handoff Rules

1. After meaningful sigil or spell execution, summarize the request, route, selected definition, outputs, files changed, validation, quality-bar status, anti-pattern hits, workflow gaps, reflection trigger, and recommendation.
2. Append one JSON object to the central invocation ledger when writing telemetry is allowed.
3. Do not store secrets, credentials, private keys, tokens, or unnecessary raw request content.
4. If telemetry cannot be written, report the failure and preserve the synthesized event in the final response.
5. Do not block the user's primary task unless observability is the primary task.
EOF_OBSERVABILITY

  cat > "$necronomicon_root/manifest.json" <<EOF_MANIFEST
{
  "version": "0.1.0",
  "name": "necronomicon",
  "install_prefix": "$install_prefix",
  "definition_root": "$install_prefix/necronomicon",
  "observability_root": "$install_prefix/observability",
  "runtime_root": "$install_prefix/runtimes",
  "registry": "$install_prefix/necronomicon/REGISTRY.md",
  "routes": "$install_prefix/necronomicon/ROUTES.md",
  "observability": "$install_prefix/necronomicon/OBSERVABILITY.md",
  "sigils": [
EOF_MANIFEST

  for index in "${!installed_sigil_ids[@]}"; do
    sigil="${installed_sigil_ids[$index]}"
    tier="${installed_sigil_tiers[$index]}"
    if [[ "$index" != "0" ]]; then
      printf ',\n' >> "$necronomicon_root/manifest.json"
    fi
    printf '    {"id":"%s","tier":"%s","definition":"%s/necronomicon/%s/%s/SKILL.md"}' "$sigil" "$tier" "$install_prefix" "$tier" "$sigil" >> "$necronomicon_root/manifest.json"
  done

  cat >> "$necronomicon_root/manifest.json" <<EOF_MANIFEST

  ],
  "spells": [
EOF_MANIFEST

  local spell_index=0
  for spell in "${installed_spell_ids[@]}"; do
    if [[ "$spell_index" != "0" ]]; then
      printf ',\n' >> "$necronomicon_root/manifest.json"
    fi
    printf '    {"id":"%s","definition":"%s/necronomicon/spells/%s.md"}' "$spell" "$install_prefix" "$spell" >> "$necronomicon_root/manifest.json"
    spell_index=$((spell_index + 1))
  done

  cat >> "$necronomicon_root/manifest.json" <<EOF_MANIFEST

  ]
}
EOF_MANIFEST
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

install_selected_sigils() {
  local selection="$1"
  local sigil tier_path tier sigil_name
  if [[ "$selection" == "all" ]]; then
    for tier in formulae transmutations arcana; do
      if [[ -f "$arcanum_root/$tier/README.md" ]]; then
        copy_path "$arcanum_root/$tier/README.md" "$necronomicon_root/$tier/README.md"
      fi
      while IFS= read -r tier_path; do
        sigil_name="$(basename "$tier_path")"
        [[ -f "$tier_path/SKILL.md" ]] || continue
        copy_path "$tier_path" "$necronomicon_root/$tier/$sigil_name"
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
    copy_path "$arcanum_root/$tier_path" "$necronomicon_root/$tier_path"
    installed_sigil_ids+=("$sigil")
    installed_sigil_tiers+=("${tier_path%%/*}")
  done
}

install_selected_spells() {
  local selection="$1"
  local spell spell_file
  if [[ "$selection" == "none" ]]; then
    return 0
  fi
  run mkdir -p "$spell_install_root"
  copy_path "$arcanum_root/spells/README.md" "$spell_install_root/README.md"
  copy_path "$arcanum_root/spells/templates" "$spell_install_root/templates"
  if [[ "$selection" == "all" ]]; then
    while IFS= read -r spell_file; do
      copy_path "$spell_file" "$spell_install_root/$(basename "$spell_file")"
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
    copy_path "$spell_file" "$spell_install_root/$spell.md"
    installed_spell_ids+=("$spell")
  done
}

write_local_registries_for_selected_install() {
  if [[ "$sigil_selection" == "all" && "$spell_selection" == "all" ]]; then
    return 0
  fi

  local registry_dir="$necronomicon_root/registry"
  run mkdir -p "$registry_dir"
  if [[ "$dry_run" == "true" ]]; then
    echo "[dry-run] write selected install registries under $registry_dir"
    return 0
  fi

  cat > "$registry_dir/SIGILS.md" <<'EOF_SIGILS'
# Installed Sigil Registry

This registry was generated by the Arcanum bootstrap script for a selected local install.

It lists only the sigils copied into this repository under `.arcanum/necronomicon/<tier>/`.

| Sigil | Tier | Folder |
| ----- | ---- | ------ |
EOF_SIGILS

  local index sigil tier title
  for index in "${!installed_sigil_ids[@]}"; do
    sigil="${installed_sigil_ids[$index]}"
    tier="${installed_sigil_tiers[$index]}"
    title="$(printf '%s' "$sigil" | tr '-' ' ')"
    printf '| %s | %s | [%s/%s/](../%s/%s/) |\n' "$title" "$tier" "$tier" "$sigil" "$tier" "$sigil" >> "$registry_dir/SIGILS.md"
  done

  cat >> "$registry_dir/SIGILS.md" <<'EOF_SIGILS'

## Canonical Source

For the full public registry, see the upstream Arcanum repository.
EOF_SIGILS

  cat > "$registry_dir/SPELLS.md" <<'EOF_SPELLS'
# Installed Spell Registry

This registry was generated by the Arcanum bootstrap script for a selected local install.

It lists only the spells copied into this repository under `.arcanum/necronomicon/spells/`.

| Spell | File |
| ----- | ---- |
EOF_SPELLS

  local spell
  for spell in "${installed_spell_ids[@]}"; do
    title="$(printf '%s' "$spell" | tr '-' ' ')"
    printf '| %s | [%s.md](../spells/%s.md) |\n' "$title" "$spell" "$spell" >> "$registry_dir/SPELLS.md"
  done

  cat >> "$registry_dir/SPELLS.md" <<'EOF_SPELLS'

## Canonical Source

For the full public spell registry, see the upstream Arcanum repository.
EOF_SPELLS

  cat > "$registry_dir/PACKS.md" <<'EOF_PACKS'
# Installed Packs

This selected local install does not generate curated pack definitions automatically.

Use the installed sigil and spell registries directly, or copy pack definitions from upstream Arcanum when the selected local install includes every referenced artifact.
EOF_PACKS
}

write_readme_for_selected_install() {
  if [[ "$sigil_selection" == "all" && "$spell_selection" == "all" ]]; then
    return 0
  fi

  local readme="$necronomicon_root/INSTALL.md"
  if [[ "$dry_run" == "true" ]]; then
    echo "[dry-run] write selected install README $readme"
    return 0
  fi

  cat > "$readme" <<'EOF_README'
# Arcanum Local Install

This is a selected local Arcanum install generated by the bootstrap script.

Canonical local references:

- [Installed Sigil Registry](registry/SIGILS.md)
- [Installed Spell Registry](registry/SPELLS.md)
- [Framework](framework/)
- [Research](research/)

The installed registry lists only artifacts copied into this repository. Re-run the bootstrap script with additional sigils, selected spells, or `--sigils all --spells all` to expand the local install.

Runtime adapters should stay thin and route through this Necronomicon package instead of copying sigil internals.
EOF_README
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
description: Route Arcanum requests through the installed local Necronomicon runtime book.
argument-hint: "<natural-language-arcanum-request>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum Orchestrate

<objective>
Route a user request through Necronomicon, the installed Arcanum runtime book for registry lookup, orchestration, and observability handoff.
</objective>

<context>
Arcanum is installed at $install_prefix/ in this repository. Read $install_prefix/necronomicon/README.md, $install_prefix/necronomicon/REGISTRY.md, $install_prefix/necronomicon/ROUTES.md, and $install_prefix/necronomicon/OBSERVABILITY.md. Use definition paths from Necronomicon when a route is selected.
</context>

<process>
1. Read the installed Necronomicon runtime files.
2. Classify the request using $install_prefix/necronomicon/ROUTES.md.
3. Select one installed sigil or spell from $install_prefix/necronomicon/REGISTRY.md. If multiple routes are plausible, ask one focused clarification.
4. Read the selected definition path named by Necronomicon.
5. Follow the selected artifact's process and preserve its Quality Bar, Anti-Patterns, output contract, and validation gates.
6. Apply the observability handoff from $install_prefix/necronomicon/OBSERVABILITY.md.
7. Return the selected route, files used, validation result, observability result, and next action.
</process>

<guardrails>
- Keep this skill as a thin runtime adapter.
- Treat $install_prefix/necronomicon/ as the runtime authority for registry and orchestration.
- Treat $install_prefix/necronomicon/formulae/, $install_prefix/necronomicon/transmutations/, $install_prefix/necronomicon/arcana/, and $install_prefix/necronomicon/spells/ as definition storage selected through Necronomicon.
- Do not copy full sigil internals into this wrapper.
</guardrails>
EOF_ADAPTER

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
The canonical local adapter lives at $install_prefix/runtimes/github-copilot/skills/$command_name/SKILL.md. Necronomicon lives under $install_prefix/necronomicon/.
</context>

<process>
1. Read $install_prefix/runtimes/github-copilot/skills/$command_name/SKILL.md.
2. Follow that adapter's process.
3. If the runtime adapter is unavailable, read $install_prefix/necronomicon/REGISTRY.md and $install_prefix/necronomicon/ROUTES.md directly.
</process>

<guardrails>
- Keep this file as a discovery bridge only.
- Do not copy full sigil internals into this wrapper.
- Treat $install_prefix/runtimes/github-copilot/ and $install_prefix/necronomicon/ as authoritative for installed runtime behavior.
</guardrails>
EOF_BRIDGE
}

write_github_copilot_artifact_adapter() {
  local artifact_kind="$1"
  local artifact_id="$2"
  local artifact_tier="$3"
  local definition_path="$4"
  local runtime_command="arcanum-$artifact_kind-$artifact_id"
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
description: Run the installed Arcanum $artifact_kind $artifact_id through Necronomicon.
argument-hint: "<request-for-$artifact_id>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum $display_kind: $display_title

<objective>
Run the installed Arcanum $artifact_kind $artifact_id through Necronomicon while preserving registry, route, and observability contracts.
</objective>

<context>
Arcanum is installed at $install_prefix/ in this repository. Necronomicon is the runtime authority at $install_prefix/necronomicon/. The selected definition is $definition_path.
</context>

<process>
1. Read $install_prefix/necronomicon/REGISTRY.md and $install_prefix/necronomicon/OBSERVABILITY.md.
2. Read $definition_path.
3. For sigils, also read the sibling README.md when it exists. For spells, follow the spell file directly.
4. Execute only the installed $artifact_kind $artifact_id unless the definition explicitly delegates or the user asks to route elsewhere.
5. Preserve the selected artifact's process, quality bar, anti-patterns, output contract, and validation gates.
6. Apply the observability handoff from $install_prefix/necronomicon/OBSERVABILITY.md.
7. Return the artifact used, files read, validation result, observability result, and next action.
</process>

<guardrails>
- Keep this skill as a thin runtime adapter for one installed artifact.
- Do not bypass Necronomicon for registry or observability behavior.
- Do not copy full sigil or spell internals into this wrapper.
</guardrails>
EOF_ADAPTER

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
3. If the runtime adapter is unavailable, read $install_prefix/necronomicon/REGISTRY.md and then $definition_path.
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

Route requests by reading:

- $install_prefix/necronomicon/REGISTRY.md
- $install_prefix/necronomicon/ROUTES.md
- $install_prefix/necronomicon/OBSERVABILITY.md

Keep this command adapter thin. The installed Arcanum files remain the canonical local source.
EOF_ADAPTER

  cat > "$bridge" <<EOF_BRIDGE
# Arcanum Orchestrate

Use the installed Arcanum runtime adapter at:

- $install_prefix/runtimes/$runtime_name/commands/$command_name.md

Necronomicon runtime files live under:

- $install_prefix/necronomicon/

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

Runtime process:

1. Read $install_prefix/necronomicon/REGISTRY.md and $install_prefix/necronomicon/OBSERVABILITY.md.
2. Read $definition_path.
3. Execute only this installed $artifact_kind unless the definition explicitly delegates or the user asks to route elsewhere.
4. Apply the Necronomicon observability handoff.
5. Report the artifact used, files read, validation result, observability result, and next action.

Keep this command adapter thin. Necronomicon remains the runtime authority.
EOF_ADAPTER

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
    definition_path="$install_prefix/necronomicon/$tier/$sigil/SKILL.md"
    write_github_copilot_artifact_adapter "sigil" "$sigil" "$tier" "$definition_path"
  done

  for spell in "${installed_spell_ids[@]}"; do
    definition_path="$install_prefix/necronomicon/spells/$spell.md"
    write_github_copilot_artifact_adapter "spell" "$spell" "spell" "$definition_path"
  done
}

write_command_individual_adapters() {
  local runtime_dir="$1"
  local index sigil tier definition_path spell
  for index in "${!installed_sigil_ids[@]}"; do
    sigil="${installed_sigil_ids[$index]}"
    tier="${installed_sigil_tiers[$index]}"
    definition_path="$install_prefix/necronomicon/$tier/$sigil/SKILL.md"
    write_command_artifact_adapter "$runtime_dir" "sigil" "$sigil" "$tier" "$definition_path"
  done

  for spell in "${installed_spell_ids[@]}"; do
    definition_path="$install_prefix/necronomicon/spells/$spell.md"
    write_command_artifact_adapter "$runtime_dir" "spell" "$spell" "spell" "$definition_path"
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

run mkdir -p "$dest_root" "$necronomicon_root"
if [[ "$force" == "true" ]]; then
  run rm -rf "$dest_root/source"
  run rm -rf "$necronomicon_root/sigils"
fi
copy_path "$arcanum_root/README.md" "$necronomicon_root/ARCANUM.md"
copy_path "$arcanum_root/framework" "$necronomicon_root/framework"
copy_path "$arcanum_root/registry" "$necronomicon_root/registry"
copy_path "$arcanum_root/research" "$necronomicon_root/research"
install_observability_package

install_selected_sigils "$sigil_selection"
install_selected_spells "$spell_selection"
write_local_registries_for_selected_install
write_readme_for_selected_install
write_necronomicon
install_runtime_adapter

echo "Arcanum bootstrap complete."
echo "Necronomicon registry: $install_prefix/necronomicon/REGISTRY.md"
if [[ "$runtime" != "none" ]]; then
  echo "Runtime adapter: $install_prefix/runtimes/$runtime / $command_name"
fi