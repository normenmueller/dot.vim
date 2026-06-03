# Agent State

This repository is a classic Vim/MacVim configuration. Do not assume Neovim or
Lua-plugin compatibility unless a branch explicitly adds it.

## Branch map

- `trunk`: baseline Vim config with the plugin sync helper.
- `feature/pimp-ui-crafted`: earlier handcrafted native UI prototype.
- `feature/pimp-ui-lightline`: earlier lightline-only UI variant.
- `feature/pimp-all-everforest`: Vim-compatible Everforest + lightline variant.
- `feature/pimp-all-zenbones`: Vim-compatible Zenbones + lightline variant.

## Plugin sync policy

`plugged/` is ignored by Git and is local machine state. Git branch switches do
not automatically remove ignored plugin checkouts. Always synchronize local
plugins after switching branches or before validating UI behavior:

```sh
./bin/sync-plugins
```

The script executes:

```sh
vim -Nu "$PWD/vimrc" -n -es +'PlugClean!' +'PlugInstall --sync' +'qa!'
```

Behavior:
- Remove plugins under `plugged/` that are not declared by the active branch.
- Install plugins declared by the active branch that are missing locally.
- Do not commit `plugged/`; it remains ignored local state.

## Expected plugin sets

- `trunk`
  - Includes legacy UI stack: NERDTree, onehalf, vim-airline, vim-airline-themes.
- `feature/pimp-ui-lightline`
  - Uses lightline + onehalf.
  - Does not use airline.
- `feature/pimp-ui-crafted`
  - Uses the handcrafted native UI prototype.
  - Contains `autoload/nemui.vim`.
- `feature/pimp-all-everforest`
  - Uses Everforest + lightline.
  - Does not use NERDTree, onehalf, vim-airline, or vim-airline-themes.
- `feature/pimp-all-zenbones`
  - Uses Zenbones + lightline.
  - Does not use NERDTree, onehalf, vim-airline, or vim-airline-themes.

Shared Vim plugins are expected across most branches: `coc.nvim`, `fzf`,
`fzf.vim`, `vim-sensible`, `vim-surround`, `vim-fugitive`, `vim-pandoc`,
`vim-pandoc-syntax`, `vim-bufkill`, and `vim-hindent`.

## Sync exit status caveat

`./bin/sync-plugins` may occasionally exit with status `1` after printing
vim-plug progress such as `Removed ... directories`, `Updating ...`, and
`Finishing ...`. Treat this as inconclusive, not immediately fatal.

The authoritative post-sync check is `PlugStatus`:

```sh
vim -Nu "$PWD/vimrc" -n -es +'PlugStatus' +'redir! > /tmp/plugstatus.txt' +'silent %print' +'redir END' +'qa!'
sed -n '1,160p' /tmp/plugstatus.txt
```

Expected healthy result:

```text
Finished. 0 error(s).
```

Zenbones and Everforest were both verified with `PlugStatus` reporting
`Finished. 0 error(s).`

## Verification commands

Use these checks after plugin sync, branch switches, or UI edits:

```sh
git status --short
find plugged -maxdepth 1 -mindepth 1 -type d -print | sort
vim -i NONE -Nu "$PWD/vimrc" -n -V1 -es +'call tglthm#toggle()' +'call tglthm#toggle()' +'messages' +'qa!'
```

For script loading validation, capture `:scriptnames` and assert that only the
branch's intended UI plugins are loaded.
