# Purpose

This file is volatile project memory and a compact current-state handoff
cockpit, not a chronological log. It is a dated snapshot and never overrides
current repository facts, command output, tests, latest user instructions, or
`.ai4X/BEHAVIOR.md`. Target 60-90 lines; hard ceiling 120 unless active
complexity explicitly requires more.

# Snapshot

- Observed: 2026-08-08 CEST.
- Branch: `trunk`, two commits ahead of `origin/trunk` after the current
  Markdown migration commit.
- Active profile: `lightline`. `plugged/` matches its declared plugin set;
  vim-pandoc directories are absent and `vim-markdown` is installed.

# Current Change

- `vimrc` replaces vim-pandoc and its settings with
  `plasticboy/vim-markdown`.
- Markdown folding uses pythonic style with level 2, TOC auto-fit is enabled,
  and inline/code-block concealment is explicitly disabled.
- The unsupported `g:vim_markdown_folding_enabled` and redundant explicit
  `*.md` filetype autocmd were removed.
- README and durable CONTEXT now describe Markdown rather than a Pandoc plugin.

# Verification

- Markdown startup: filetype `markdown`, expected vim-markdown scripts loaded,
  `foldmethod=expr`, `foldlevel=2`, `:Toc`/`:InsertToc` present, no `j`/`k`
  override, and no Vim error.
- `.pandoc` boundary: built-in filetype `pandoc`, manual folding, no vim-markdown
  TOC command, and no Vim error.
- `PlugStatus`: `Finished. 0 error(s).`; CoC build and fzf executable healthy.
- Repeated theme toggle exited zero. `git diff --check` passed.

# Stable Facts

- All UI variants are profiles on `trunk`; fallback is `legacy`.
- No Markdown language server configured; `coc-settings.json` has Haskell only.
- `.pandoc` files intentionally retain Vim's built-in Pandoc syntax and do not
  receive vim-markdown folding, commands, or mappings.
- `docs/profiles.md`: profile/sync/theme. `docs/coc-lsp.md`: LSP workflow.
- Canonical agent memory: `.ai4X/` only. `AGENTS.md` and
  `.github/agents/vim.agent.md` are behavior adapters.
- Apache License 2.0; README ends with 2026 `nemron` copyright notice.

# Risks

- Only the active `lightline` plugin set was runtime-validated; declarations
  are shared, but other profiles require synchronization before validation.
- vim-markdown retains its default buffer-local Markdown navigation mappings.
- Haskell Language Server is an external executable, not installed by vim-plug.

# Next Actions

1. Await next task. On re-entry: confirm Git status and re-read `.ai4X/`.
