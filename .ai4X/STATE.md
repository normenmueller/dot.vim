# Purpose

This file is volatile project memory and a compact current-state handoff
cockpit, not a chronological log. It is a dated snapshot and never overrides
current repository facts, command output, tests, latest user instructions, or
`.ai4X/BEHAVIOR.md`. Target 60-90 lines; hard ceiling 120 unless active
complexity explicitly requires more.

# Snapshot

- Observed: 2026-07-29 CEST.
- Branch: `trunk`; worktree clean; no ahead/behind marker (verify on re-entry).
- Active profile: `lightline`. `plugged/` matches lightline expectation.

# Last Change

- Commit `333d311`: `let g:pandoc#keyboard#display_motions = 0` added to
  vimrc (pandoc config block, ~line 260).
- Root cause: vim-pandoc defaults `formatting#mode='s'` + `display_motions=1`,
  which silently sets buffer-local `j→gj`/`k→gk` in all pandoc/markdown
  buffers, overriding the global fix from `39d9efe`.
- `j`/`k` now move by real file lines everywhere. `<C-j>`/`<C-k>` retain
  visual-line movement.

# Stable Facts

- All UI variants are profiles on `trunk`; fallback is `legacy`.
- No Markdown language server configured; `coc-settings.json` has Haskell only.
- `docs/profiles.md`: profile/sync/theme. `docs/coc-lsp.md`: LSP workflow.
- Canonical agent memory: `.ai4X/` only. `AGENTS.md` and
  `.github/agents/vim.agent.md` are behavior adapters.
- Apache License 2.0; README ends with 2026 `nemron` copyright notice.

# Risks

- Plugin-specific keyboard modules (e.g. vim-pandoc) may set buffer-local
  mappings that silently override global vimrc settings. Check with
  `:verbose nmap <key>` in the affected filetype buffer.
- Profile-specific plugins differ; sync before starting Vim after switching.
- Haskell Language Server is an external executable, not installed by vim-plug.

# Next Actions

1. Await next task. On re-entry: confirm Git status, re-read all `.ai4X/` files.
