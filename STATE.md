# Agent State

This repository is a classic Vim/MacVim configuration, not a Neovim config.

## Current branch state

- Current branch: `feature/pimp-all-zenbones`.
- Working tree is expected to be clean except for this `STATE.md` if not yet committed.
- Relevant local branches:
  - `trunk`
    - Contains `bin/sync-plugins`.
    - Commit: `4de9ce3 Add plugin sync helper`.
  - `feature/pimp-all-everforest`
    - Everforest + lightline Vim UI variant.
    - Contains `bin/sync-plugins`.
    - Commit: `c8502bf Add plugin sync helper`.
  - `feature/pimp-all-zenbones`
    - Zenbones + lightline Vim UI variant.
    - Contains `bin/sync-plugins`.
    - Commit: `e028d25 Add plugin sync helper`.
  - `feature/pimp-ui-lightline`
    - Earlier lightline-only UI variant.
  - `feature/pimp-ui-crafted`
    - Earlier native handcrafted UI prototype.

## Plugin synchronization policy

`plugged/` is ignored by Git and is local machine state. Branch switches do not
automatically remove ignored plugin checkouts. To keep the local plugin checkout
matching the active branch, run:

```sh
./bin/sync-plugins
```

The script executes:

```sh
vim -Nu "$PWD/vimrc" -n -es +'PlugClean!' +'PlugInstall --sync' +'qa!'
```

Effects:
- Remove plugins under `plugged/` that are not declared by the active branch.
- Install plugins declared by the active branch that are missing locally.
- Do not commit `plugged/`; it remains ignored local state.

## Current local plugin state

After synchronizing `feature/pimp-all-zenbones`, `plugged/` should contain only
the Zenbones branch plugin set:

- `zenbones.nvim`
- `lightline.vim`
- `coc.nvim`
- `fzf`
- `fzf.vim`
- shared Vim plugins such as `vim-sensible`, `vim-surround`, `vim-fugitive`,
  `vim-pandoc`, `vim-pandoc-syntax`, `vim-bufkill`, and `vim-hindent`

It should not contain `everforest`, `nerdtree`, `onehalf`, `vim-airline`, or
`vim-airline-themes` while `feature/pimp-all-zenbones` is active and synced.

## Verification commands

Use these checks after plugin sync or branch switches:

```sh
git status --short
find plugged -maxdepth 1 -mindepth 1 -type d -print | sort
vim -Nu "$PWD/vimrc" -n -es +'PlugStatus' +'redir! > /tmp/plugstatus.txt' +'silent %print' +'redir END' +'qa!'
sed -n '1,160p' /tmp/plugstatus.txt
```

Expected `PlugStatus` result for a healthy branch:

```text
Finished. 0 error(s).
```

Note: `./bin/sync-plugins` may occasionally exit with status `1` after printing
vim-plug progress such as `Removed ... directories`, `Updating ...`, and
`Finishing ...`. Treat this as inconclusive rather than immediately fatal.
Always verify with `PlugStatus`; Zenbones and Everforest were both verified with
`Finished. 0 error(s).`
