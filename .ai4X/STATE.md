# Purpose

This file is volatile project memory and a compact current-state handoff
cockpit, not a chronological log. It is a dated snapshot and never overrides
current repository facts, command output, tests, latest user instructions, or
`.ai4X/BEHAVIOR.md`. Target 60-90 lines; hard ceiling 120 unless active
complexity explicitly requires more.

# Snapshot

- Observed: 2026-07-17 CEST.
- Phase: profile migration, bootstrap consolidation, and documentation cleanup
  complete; no implementation task remains active.
- Bootstrap files were merged from prior `AGENTS.md` and `STATE.md` material,
  then versioned under `.ai4X/`; host adapters link to canonical behavior.
- Observation boundary: status was inspected before edits; this state file is
  updated by the documentation commit. Final status and remote synchronization
  were verified after publication.

# Evidence Freshness

- Inspected: all canonical `.ai4X/` files, Git status/history, README, `docs/`,
  `vimrc`, `coc-settings.json`, profiles, theme code, and profile/sync scripts.
- Runtime evidence: direct rename mapping lookup, theme toggle smoke test, all
  documentation links, shell syntax, plugin status, and repository searches.
- Active-session evidence includes explicit user decisions on README scope,
  documentation structure, obsolete content, commit boundaries, and direct
  publication to `origin/trunk`.
- Not re-inspected in detail: unrelated syntax and spell files.

# Active Objective

No active implementation objective remains. Success for this handoff means a
clean `trunk` synchronized with `origin/trunk`, with the profile workflow and
lean documentation ready for normal use.

# Current Worktree

- Branch: `trunk`, tracking `origin/trunk`, clean and synchronized at handoff.
- The completed work is split into three focused commits: canonical AI
  bootstrap memory, obsolete Vim cleanup, and streamlined user documentation.
- The user-created Copilot CLI adapter was intentionally included; no unrelated
  uncommitted changes remain.

# Current Focus

- All UI variants are profiles on `trunk`; local selection no longer uses Git
  branches. The fallback remains `legacy`.
- `<Space>rn` is the direct CoC rename mapping. Obsolete BufExplorer comments
  and its orphaned vendored help file are removed.
- README is a concise landing page with the working `lightline` quick start,
  profile table, essential commands, and links to detailed guides.
- `docs/profiles.md` owns selection precedence, synchronization, themes, and
  vim-plug troubleshooting. `docs/coc-marksman.md` owns the LSP workflow.
- Canonical agent memory lives only in `.ai4X/`; `AGENTS.md` and
  `.github/agents/vim.agent.md` are behavior adapters without duplicated content.

# Next Actions

1. On re-entry, confirm current Git status and read the three canonical
   `.ai4X/` files before acting.
2. For normal use, run `./bin/use-profile PROFILE`; use `:VimProfile` to confirm
   the selection and `:ToggleTheme` to switch theme mode.
3. Update documentation only when observable behavior changes; keep README
   lean and put operational depth in `docs/`.

# Accepted Decisions Relevant Now

- `trunk` is the single maintained branch; UI choices are profiles, not
  long-lived branches.
- Human Markdown guides use `docs/`; Vim help uses `doc/` only when maintained.
- README stays English, factual, and within roughly 70-90 lines.
- Direct publication to `origin/trunk` was explicitly authorized for this work.

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
- README length, local links, shell syntax, whitespace, and staged scope passed.
- The three focused commits were published to `origin/trunk`; local and remote
  `trunk` commit identities matched at handoff.
