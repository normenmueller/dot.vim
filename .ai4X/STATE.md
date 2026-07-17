# Purpose

This file is volatile project memory and a compact current-state handoff
cockpit, not a chronological log. It is a dated snapshot and never overrides
current repository facts, command output, tests, latest user instructions, or
`.ai4X/BEHAVIOR.md`. Target 60-90 lines; hard ceiling 120 unless active
complexity explicitly requires more.

# Snapshot

- Observed: 2026-07-17 CEST.
- Phase: Apache License 2.0 addition complete and committed locally; no
  implementation task remains active.
- Bootstrap files were merged from prior `AGENTS.md` and `STATE.md` material,
  then versioned under `.ai4X/`; host adapters link to canonical behavior.
- Observation boundary: status was inspected before licensing edits; this file
  is part of the licensing commit. Post-commit status was verified at handoff.

# Evidence Freshness

- Inspected: all canonical `.ai4X/` files, Git status/history, README, LICENSE,
  and the official GitHub Apache-2.0 license template.
- Runtime evidence: direct rename mapping lookup, theme toggle smoke test, all
  documentation links, shell syntax, plugin status, and repository searches.
- Active-session evidence includes the explicit user decision to adopt GitHub's
  Apache License 2.0 template and the exact README notice.
- Not re-inspected in detail: unrelated syntax and spell files.

# Active Objective

No active implementation objective remains. The licensing change is complete
when `LICENSE`, the README notice, and canonical `.ai4X/` memory form one clean
local commit.

# Current Worktree

- Branch: `trunk`, clean and one licensing commit ahead of `origin/trunk` at
  handoff; publication was not requested in this task.
- No unrelated or user-owned uncommitted changes were observed.

# Current Focus

- All UI variants are profiles on `trunk`; local selection no longer uses Git
  branches. The fallback remains `legacy`.
- `<Space>rn` is the direct CoC rename mapping. Obsolete BufExplorer comments
  and its orphaned vendored help file are removed.
- README is a concise landing page with the working `lightline` quick start,
  profile table, essential commands, and links to detailed guides.
- `LICENSE` contains GitHub's standard Apache License 2.0 template. README ends
  with the requested 2026 `nemron` copyright notice and license link.
- `docs/profiles.md` owns selection precedence, synchronization, themes, and
  vim-plug troubleshooting. `docs/coc-marksman.md` owns the LSP workflow.
- Canonical agent memory lives only in `.ai4X/`; `AGENTS.md` and
  `.github/agents/vim.agent.md` are behavior adapters without duplicated content.

# Next Actions

1. Push the local licensing commit only when the user requests publication.
2. On re-entry, confirm Git status and read all three canonical `.ai4X/` files.
3. For normal use, run `./bin/use-profile PROFILE`; use `:VimProfile` and
   `:ToggleTheme` to inspect the profile and switch theme mode.

# Accepted Decisions Relevant Now

- `trunk` is the single maintained branch; UI choices are profiles, not
  long-lived branches.
- Human Markdown guides use `docs/`; Vim help uses `doc/` only when maintained.
- README stays English, factual, and within roughly 70-90 lines.
- The project uses Apache License 2.0 with the unmodified GitHub template.

# Risks

- Profile-specific plugins differ. A temporary profile must be synchronized
  before Vim starts, or commands/colorschemes may be missing.
- Marksman and Haskell Language Server are external executables and are not
  installed by vim-plug.

# Verification Summary

- Vim loaded the `lightline` profile and resolved `<Space>rn` to
  `<Plug>(coc-rename)`; dark/light toggling succeeded headlessly.
- Documentation claims were checked against Vimscript, CoC settings, profile
  scripts, and plugin declarations; stale Fugitive and backup claims removed.
- README remains at 90 lines and its relative LICENSE link resolves locally.
- LICENSE matched GitHub's `licenses/apache-2.0` API body byte-for-byte; diff
  whitespace and committed scope passed.
