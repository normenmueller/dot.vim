# Agent Instructions

This repository contains a classic Vim/MacVim setup. Treat Neovim-only plugins,
Lua-first configuration patterns, and Neovim UI assumptions as out of scope
unless the user explicitly requests a Neovim migration or experiment.

## Operating principles

- Preserve Vim/MacVim compatibility by default.
- Prefer small, reversible changes on feature branches for UI experiments.
- Keep branch state clean: commit intentional tracked changes and avoid leaving
  unrelated edits in the working tree.
- Do not commit `plugged/`; it is ignored local machine state.
- Do not use destructive Git commands unless the user explicitly asks for them.
- Read `STATE.md` before making branch, plugin, or UI changes. It records the
  current branch map, plugin sets, and verification caveats.

## Plugin management

- Plugins are managed with `vim-plug` from `vimrc`.
- `plugged/` must match the active branch when validating behavior.
- After switching branches, run:

```sh
./bin/sync-plugins
```

- If `./bin/sync-plugins` exits with status `1` after printing vim-plug progress,
  do not treat that alone as failure. Verify with `PlugStatus`.
- Use this as the authoritative post-sync check:

```sh
vim -Nu "$PWD/vimrc" -n -es +'PlugStatus' +'redir! > /tmp/plugstatus.txt' +'silent %print' +'redir END' +'qa!'
sed -n '1,160p' /tmp/plugstatus.txt
```

- Healthy result:

```text
Finished. 0 error(s).
```

## UI experimentation guidance

- Do not propose or add Neovim-only UI plugins such as `lualine.nvim`,
  `telescope.nvim`, `treesitter-context`, or `incline.nvim` for this Vim config.
- Vim-compatible substitutes used here:
  - `lightline.vim` for statusline/tabline experiments.
  - `fzf.vim` for file and buffer navigation.
  - CoC Outline and CoC symbol lists for code navigation.
  - Native Vim splits, tabs, and buffers for layout.
- File-tree sidebars and bufferlines are intentionally absent in the
  `feature/pimp-all-*` branches. The navigation model is query-driven:
  `<C-P>` / `:Files`, `:Buffers`, `<space>o`, `<space>s`, `gd`, `gr`, and native
  window commands.

## Verification checklist

Before reporting a UI/plugin branch as ready:

```sh
git status --short
./bin/sync-plugins
vim -Nu "$PWD/vimrc" -n -es +'PlugStatus' +'redir! > /tmp/plugstatus.txt' +'silent %print' +'redir END' +'qa!'
sed -n '1,160p' /tmp/plugstatus.txt
vim -i NONE -Nu "$PWD/vimrc" -n -V1 -es +'call tglthm#toggle()' +'call tglthm#toggle()' +'messages' +'qa!'
```

For script-loading checks, capture `:scriptnames` and confirm only the intended
UI plugin stack for the active branch is loaded.

## Documentation split

- `AGENTS.md`: durable behavior rules and repository working conventions.
- `STATE.md`: current branch map, plugin state expectations, and operational
  facts that future agents should inspect before work.
