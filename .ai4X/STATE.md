# Purpose

This file is volatile project memory and a compact current-state handoff
cockpit, not a chronological log. It is a dated snapshot and never overrides
current repository facts, command output, tests, latest user instructions, or
`.ai4X/BEHAVIOR.md`. Target 60-90 lines; hard ceiling 120 unless active
complexity explicitly requires more.

# Snapshot

- Observed: 2026-07-19 CEST.
- Phase: Markdown language-server removal complete; no implementation task
  remains active.
- Bootstrap files remain canonical under `.ai4X/`; host adapters link to
  behavior only.
- Prior state claimed one local licensing commit ahead of `origin/trunk`; that
  claim is now stale. Current Git status is clean on `trunk` with no
  ahead/behind marker.

# Evidence Freshness

- Inspected: all canonical `.ai4X/` files, Git status/history, README, main
  runtime files (`vimrc`, `profiles/*.vim`, `autoload/*.vim`, `plugin/`),
  operational scripts (`bin/use-profile`, `bin/sync-plugins`), CoC settings,
  local profile selection, and installed plugin directory names.
- Runtime evidence in this session: selection precedence, conditional
  vim-plug declarations, theme toggle architecture, profile helper structure,
  shell sync flow, and current local plugin/profile alignment.
- Not re-inspected in detail: unrelated syntax, spell, and older auxiliary
  runtime files outside the current profile/theme/sync path.

# Active Objective

No implementation task is active. The latest completed change removed the
Markdown language server from local Homebrew state, CoC configuration, and
human/agent documentation.

# Current Worktree

- Branch: `trunk`; publication state should be re-checked on re-entry because
  local commits may exist even when the worktree is clean.
- No unrelated or user-owned uncommitted changes were observed during the
  cleanup task.

# Current Focus

- All UI variants are profiles on `trunk`; local selection no longer uses Git
  branches. The fallback remains `legacy`.
- Current local selection in `profile.local.vim`: `lightline`.
- Current `plugged/` contents match the `lightline` profile expectation:
  Lightline, Onehalf, and NERDTree are present; Airline, Everforest, and
  Zenbones-specific plugins are absent.
- `<Space>rn` is the direct CoC rename mapping. Obsolete BufExplorer comments
  and its orphaned vendored help file are removed.
- README is a concise landing page with the working `lightline` quick start,
  profile table, essential commands, and links to detailed guides.
- No Markdown language server is configured. `coc-settings.json` now defines
  only the Haskell language server, and Markdown/Pandoc buffers no longer have
  a configured CoC language server.
- `LICENSE` contains GitHub's standard Apache License 2.0 template. README ends
  with the requested 2026 `nemron` copyright notice and license link.
- `docs/profiles.md` owns selection precedence, synchronization, themes, and
  vim-plug troubleshooting. `docs/coc-lsp.md` owns the LSP workflow.
- Canonical agent memory lives only in `.ai4X/`; `AGENTS.md` and
  `.github/agents/vim.agent.md` are behavior adapters without duplicated content.

# Next Actions

1. Await the user's next concrete task or an explicit publication request.
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
- Haskell Language Server is an external executable and is not installed by
  vim-plug.

# Verification Summary

- This session confirmed the repository root, current branch, recent history,
  available profiles, selected local profile, current plugin directory
  contents, and the main profile/theme/sync code paths.
- The previous ahead-of-origin claim in this file was disproved by current Git
  status and replaced.
- The latest language-server cleanup removed the Homebrew formula, deleted all
  repository references to it, renamed the CoC guide to `docs/coc-lsp.md`, and
  confirmed headless Vim startup.
