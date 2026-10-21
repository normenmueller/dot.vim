# Purpose

This file is volatile project memory and a compact current-state handoff
cockpit, not a chronological log. It is a dated snapshot and never overrides
current repository facts, command output, tests, latest user instructions, or
`.ai4X/BEHAVIOR.md`. Target 60-90 lines; hard ceiling 120 unless active
complexity explicitly requires more.

# Snapshot

- Observed: 2026-10-21 CEST; prepared for a new session without chat history.
- Active objective: none; the requested NERDTree change is complete.
- Cold-start entry clarified: both requested natural greetings are now covered
  by the canonical BEHAVIOR protocol, including fresh CLI sessions.
- Latest functional commit: `7582566` (`Hide macOS metadata in NERDTree`),
  successfully pushed to `origin/trunk`.
- Before this handoff documentation update, `trunk` and `origin/trunk` matched
  with a clean worktree. Recheck Git on entry; this is a dated snapshot.
- Active local profile: `lightline`; exact installed plugin set was verified.

# Completed Work

- Extended `g:NERDTreeIgnore` in `nemprofile#configure_nerdtree()` with
  `\.DS_Store$`, `\.localized$`, and `__MACOSX`.
- Preserved the existing `\~$` backup-file filter and explicit global scope.
- Policy applies centrally to `legacy`, `lightline`, and `crafted`.
- `everforest` and `zenbones` remain without NERDTree configuration.
- No plugin declarations, local selection, or installed plugins changed.
- Durable NERDTree policy is documented in CONTEXT; natural session entry is
  defined in BEHAVIOR. Adapter symlinks remain unchanged. Old pending Markdown
  and NERDTree publication steps are obsolete; both changes are published.

# Verification

- All checks below passed on 2026-10-21 in the closing session.
- All five profile files were sourced in isolated Vim processes.
- Each NERDTree profile loaded the installed NERDTree plugin explicitly and
  opened a temporary fixture with hidden files enabled.
- `.DS_Store`, `.localized`, `__MACOSX`, and `notes.md~` were hidden;
  `.keep` and `notes.md` remained visible.
- Disabling the ignore filter revealed all four ignored entries, confirming
  that the ignore policy caused their exclusion.
- Both profiles without NERDTree left the ignore global and tree mapping unset.
- Full startup using repository `vimrc` passed for active `lightline`.
- Active installed directories exactly matched `g:plugs` declarations.
- `PlugStatus`: `Finished. 0 error(s).`; CoC build artifact nonempty; fzf
  executable; `:scriptnames` confirmed NERDTree loaded.
- Temporary validation fixtures were removed. No test suite was added.
- Other profiles received configuration/filter checks; their full UI startup
  and theme toggles were not repeated for this filter-only change.
- Handoff checks passed: canonical file roles, adapter targets, path/link
  references, profile policy, line budget, and whitespace diff checks.

# Open Decisions And Risks

- No open decisions, blockers, or unfinished implementation tasks.
- Haskell Language Server remains an external executable, not installed by
  vim-plug. No new risk was identified for the NERDTree change.

# Cold Start

- Follow BEHAVIOR's Cold Start And Re-entry section through the existing
  `AGENTS.md` adapter. No special opening prompt or previous chat is required.
- Both greetings should currently report completed work and no open tasks.
- Actual behavior in a separately launched fresh Codex CLI session is
  UNVERIFIED; instruction consistency is checked locally.
