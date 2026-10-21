# Purpose

This file is volatile project memory and a compact current-state handoff
cockpit, not a chronological log. It is a dated snapshot and never overrides
current repository facts, command output, tests, latest user instructions, or
`.ai4X/BEHAVIOR.md`. Target 60-90 lines; hard ceiling 120 unless active
complexity explicitly requires more.

# Snapshot

- Observed: 2026-10-21 CEST.
- Branch: `trunk`; user authorized committing and pushing the NERDTree change
  directly to `origin/trunk`.
- Starting HEAD: `a5ccf3f` (`Add notitle`); worktree was clean.
- Active profile: `lightline`; its exact installed plugin set was verified.
- Previous snapshot was stale: the Markdown change is already committed as
  `3be53a1`, followed by movement, CoC hook, and title changes.

# Current Change

- Extend `g:NERDTreeIgnore` in `nemprofile#configure_nerdtree()` with the
  requested macOS metadata patterns: `\.DS_Store$`, `\.localized$`, `__MACOSX`.
- Preserve the existing `\~$` backup-file filter and explicit global scope.
- Shared helper applies this policy to `legacy`, `lightline`, and `crafted`.
- `everforest` and `zenbones` remain without NERDTree configuration.
- No plugin declarations, local profile selection, or installed plugins changed.

# Verification

- All five profile files were sourced in isolated Vim processes.
- For each NERDTree profile, the installed NERDTree plugin was loaded explicitly
  and a temporary fixture was opened with hidden files enabled.
- `.DS_Store`, `.localized`, `__MACOSX`, and `notes.md~` were absent from the
  rendered tree; `.keep` and `notes.md` remained visible.
- Disabling the ignore filter made all four ignored fixture entries visible,
  confirming that the ignore policy caused their exclusion.
- Both profiles without NERDTree left the ignore global and tree mapping unset.
- Full startup with repository `vimrc` passed for active `lightline`.
- Active-profile installed directories exactly matched `g:plugs` declarations.
- `PlugStatus` reported `Finished. 0 error(s).`; CoC build artifact was nonempty
  and fzf artifact executable. `:scriptnames` confirmed NERDTree loaded.
- Temporary validation files lived outside the repository and were removed.
- Other profiles received configuration/filter checks; full startup of their
  complete UI stacks was not repeated for this filter-only change.

# Stable Facts

- All UI variants are profiles on `trunk`; fallback is `legacy`.
- Markdown uses built-in folding with the narrow frontmatter-aware wrapper.
- No Markdown language server is configured; `coc-settings.json` has Haskell
  only. Markdown and Pandoc files use Vim's built-in runtime support.
- `docs/profiles.md`: profile/sync/theme. `docs/coc-lsp.md`: LSP workflow.
- Canonical agent memory: `.ai4X/` only; adapters remain unchanged.
- Apache License 2.0; README ends with 2026 `nemron` copyright notice.

# Risks And Next Actions

- Haskell Language Server is an external executable, not installed by vim-plug.
- No configuration decisions remain; finish the authorized commit/push and
  verify branch synchronization with `origin/trunk`.
