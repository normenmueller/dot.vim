# Purpose

This file is volatile project memory and a compact current-state handoff
cockpit, not a chronological log. It is a dated snapshot and never overrides
current repository facts, command output, tests, latest user instructions, or
`.ai4X/BEHAVIOR.md`. Target 60-90 lines; hard ceiling 120 unless active
complexity explicitly requires more.

# Snapshot

- Observed: 2026-07-17 18:59 CEST.
- Phase: README information-architecture review after versioning the canonical
  `.ai4X/` bootstrap.
- Bootstrap is versioned in the current focused commit: three canonical files,
  `AGENTS.md -> .ai4X/BEHAVIOR.md`, and no root `STATE.md`.
- Git baseline before this state refresh: `trunk`, one local commit ahead of
  `origin/trunk`, clean worktree; README unchanged.
- Observation boundary: this state refresh is included by amending the same
  bootstrap commit; post-amend status was verified at handoff.

# Evidence Freshness

- Inspected: canonical `.ai4X/` files, Git status/current commit, full README,
  `vimrc`, `coc-settings.json`, profile/sync scripts, `doc/`, and repository-wide
  references for README claims and BufExplorer.
- Active-session evidence includes the completed profile migration, all-profile
  verification, independent Vim/shell review, and explicit user requests.
- README facts were checked against runtime mappings, backup settings, profile
  selection precedence, theme commands, and plugin synchronization behavior.
- Not inspected in detail for this review: unrelated syntax and spell files.

# Active Objective

Decide whether to implement the completed README reduction and `doc/` split
recommendation. Success for the next step requires explicit user agreement on
mapping intent and documentation scope before changing human-facing behavior.

# Current Worktree

- Branch: `trunk`, tracking `origin/trunk`, expected one local commit ahead.
- README and `doc/` were reviewed read-only and remain unchanged.
- Post-amend status verified clean; no unrelated edits were observed.

# Current Focus

- README is 164 lines / 713 words. Length is moderate, but it mixes quick start,
  feature marketing, detailed profile operations, CoC reference, fallback
  installation, and an optional snippet.
- Confirmed documentation defects: `<Space>rn` disagrees with actual
  `<Leader>rn`; the temporary Zenbones example starts Vim before syncing its
  plugins; backup-directory wording contradicts `nobackup`/`nowritebackup`.
- Weak or unverified wording includes autoformat-on-save, deprecated-looking
  Fugitive examples, and broad marketing claims.
- `doc/bufexplorer.txt` is a 792-line orphaned vendor help file; BufExplorer is
  commented out in `vimrc`. Its removal is separate from README extraction.

# Next Actions

1. Present the read-only findings and recommended target structure to the user.
2. If approved, reduce README to quick start, concise capabilities, profile
   table, essential commands, and links to detailed documentation.
3. Proposed extraction: `doc/profiles.md` for selection/sync/theme behavior and
   `doc/coc-marksman.md` for mappings, workspace roots, and optional CoC usage.
4. Resolve rename mapping intent before editing: document `<Leader>rn` or change
   the actual mapping to `<Space>rn`.
5. Decide separately whether to delete orphaned `doc/bufexplorer.txt`.

# Open Questions

- Should rename remain `<Leader>rn` (default `\rn`) or become `<Space>rn` to
  match the other direct Space mappings and current README intent?
- Should `doc/` mix project Markdown guides with Vim help `.txt`, or should the
  stale BufExplorer help be removed first?
- After an approved refactor, should README target roughly 70-90 lines or an
  even smaller landing page?

# Risks

- Moving all operational detail out of README can make first-time setup harder;
  retain one working default path and essential commands on the landing page.
- Documentation-only correction of rename may preserve an unintuitive mapping;
  code-only correction changes user behavior. Treat this as a user decision.

# Verification Summary

- Bootstrap commit created; cached scope excluded README.
- README audited with line-numbered read, word/line count, repository search,
  and direct comparison to Vimscript, CoC settings, scripts, and existing docs.
- `doc/bufexplorer.txt` orphan status confirmed by repository-wide search.
- Final post-amend Git status verified clean; commit identity is current `HEAD`.
