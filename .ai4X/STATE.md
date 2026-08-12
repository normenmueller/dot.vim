# Purpose

This file is volatile project memory and a compact current-state handoff
cockpit, not a chronological log. It is a dated snapshot and never overrides
current repository facts, command output, tests, latest user instructions, or
`.ai4X/BEHAVIOR.md`. Target 60-90 lines; hard ceiling 120 unless active
complexity explicitly requires more.

# Snapshot

- Observed: 2026-08-12 CEST.
- Branch: `trunk`; current Markdown folding change is targeted for direct push
  to `origin/trunk`.
- Active profile: `lightline`; its exact plugin set is restored after
  per-profile validation.

# Current Change

- Remove `plasticboy/vim-markdown` and all of its configuration from the common
  Vim setup; retain Vim's built-in Markdown filetype and syntax support.
- Enable Vim's built-in heading-based Markdown folding with fold level 0 so
  documents initially open with all heading folds closed.
- Wrap the built-in fold expression narrowly so a closing YAML frontmatter
  delimiter is not mistaken for a Setext level-2 heading.
- README and durable CONTEXT no longer advertise a dedicated Markdown plugin.

# Verification

- Active-profile synchronization removed `plugged/vim-markdown`; `PlugStatus`
  reports `Finished. 0 error(s).`, with healthy CoC and fzf artifacts.
- All five profiles were synchronized and passed Markdown startup plus two theme
  toggles; filetype remained `markdown`, no vim-markdown runtime script loaded,
  and `:Toc`/`:InsertToc` were absent.
- Built-in folding verification on `README.md` passed: filetype `markdown`,
  `foldmethod=expr`, custom frontmatter-aware delegation to `MarkdownFold()`,
  built-in fold text, initial fold level 0, and no external Markdown runtime
  script.
- YAML frontmatter regression verification against the user-provided
  `Scratch.md` passed: lines before and at the closing delimiter remain outside
  folds, while `# Einleitung` begins the expected closed level-1 fold.
- A synthetic document confirmed that a genuine later Setext level-2 heading
  still folds normally; the workaround is limited to the first frontmatter
  closing delimiter.
- Runtime configuration and human documentation contain no `plasticboy`,
  `vim-markdown`, `g:vim_markdown_*`, or `g:html_my_rendering` references; this
  state file names them only to record their removal.
- `git diff --check` passed after the final state update.

# Stable Facts

- All UI variants are profiles on `trunk`; fallback is `legacy`.
- No Markdown language server is configured; `coc-settings.json` has Haskell
  only. Markdown and Pandoc files use Vim's built-in runtime support.
- `docs/profiles.md`: profile/sync/theme. `docs/coc-lsp.md`: LSP workflow.
- Canonical agent memory: `.ai4X/` only. `AGENTS.md` and
  `.github/agents/vim.agent.md` are behavior adapters.
- Apache License 2.0; README ends with 2026 `nemron` copyright notice.

# Risks

- Haskell Language Server is an external executable, not installed by vim-plug.

# Next Actions

1. Await the next task after publishing the current change.
