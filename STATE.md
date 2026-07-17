# Agent State

This repository is a classic Vim/MacVim configuration. Do not assume Neovim or
Lua-plugin compatibility unless a profile explicitly adds it.

## Repository model

- `trunk` is the single maintained branch and contains shared configuration.
- UI variants are profiles under `profiles/`, not Git branches.
- `profile.local.vim` is ignored local state and selects the persistent profile.
- `VIM_PROFILE` temporarily overrides the local selection for one process.
- `:VimProfile` reports the active profile.

The historical feature branches were archived as tags after the profile
migration. They are not development bases for future changes.

## Profile map

- `legacy`
  - vim-airline, vim-airline-themes, Onehalf, and NERDTree.
- `lightline`
  - lightline, Onehalf, and NERDTree.
- `crafted`
  - handcrafted native statusline/tabline, Onehalf, and NERDTree.
  - Uses `autoload/nemui.vim`.
- `everforest`
  - Everforest and lightline.
  - Query-driven navigation without NERDTree.
- `zenbones`
  - Zenbones and lightline.
  - Query-driven navigation without NERDTree.

Shared plugins include `coc.nvim`, `fzf`, `fzf.vim`, `vim-sensible`,
`vim-surround`, `vim-fugitive`, `vim-pandoc`, `vim-pandoc-syntax`,
`vim-bufkill`, and `vim-hindent`.

## Profile selection

Select a persistent profile and synchronize its plugins:

```sh
./bin/use-profile lightline
```

Select without synchronizing immediately:

```sh
./bin/use-profile --no-sync crafted
./bin/sync-plugins
```

Exercise a profile without changing the persistent selection:

```sh
VIM_PROFILE=everforest vim -Nu "$PWD/vimrc"
./bin/sync-plugins everforest
```

## Plugin sync policy

`plugged/` is ignored local machine state. It must match the selected profile.
`./bin/use-profile` synchronizes by default; `./bin/sync-plugins [profile]` can
also be called directly.

The sync script installs missing plugins before cleaning obsolete ones, then
runs `PlugStatus` and checks CoC's build output plus the fzf executable.
vim-plug may occasionally return status `1` after normal progress; the script
normalizes this to success only when all verification checks pass. A non-zero
script result therefore means verification failed.

```sh
vim -Nu "$PWD/vimrc" -n -es \
  +'PlugStatus' \
  +'redir! > /tmp/plugstatus.txt' \
  +'silent %print' \
  +'redir END' \
  +'qa!'
sed -n '1,160p' /tmp/plugstatus.txt
```

Expected healthy result:

```text
Finished. 0 error(s).
```

## Verification

Validate each profile after shared, plugin, or UI changes:

```sh
./bin/sync-plugins PROFILE
VIM_PROFILE=PROFILE vim -Nu "$PWD/vimrc" -n -es \
  +'PlugStatus' \
  +'redir! > /tmp/plugstatus.txt' \
  +'silent %print' \
  +'redir END' \
  +'qa!'
VIM_PROFILE=PROFILE vim -i NONE -Nu "$PWD/vimrc" -n -V1 -es \
  +'call tglthm#toggle()' \
  +'call tglthm#toggle()' \
  +'messages' \
  +'qa!'
```

For script-loading checks, capture `:scriptnames` and confirm that only the
selected profile's intended UI plugin stack is loaded.
