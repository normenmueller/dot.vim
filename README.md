# Vim Configuration

Classic Vim and MacVim configuration for macOS and Linux. Shared editor
behavior stays on `trunk`; the UI is selected locally through a profile.

## Highlights

- Five UI profiles without branch switching or worktree changes.
- CoC language support and built-in Markdown folding.
- FZF navigation and Fugitive Git integration.
- Persistent undo, isolated swap files, and profile-aware dark/light themes.

## Requirements

- Vim or MacVim, Git, and `curl`.
- Node.js and npm for CoC.

## Quick start

Back up any existing Vim configuration manually before continuing.

```sh
git clone https://github.com/normenmueller/dot.vim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
cd ~/.vim
./bin/use-profile lightline
```

The last command installs and verifies the required plugins before saving the
local profile selection. Without a saved selection, Vim uses `legacy`.

## Profiles

| Profile | UI | Theme | NERDTree |
| --- | --- | --- | --- |
| `legacy` | vim-airline | Onehalf | yes |
| `lightline` | lightline | Onehalf | yes |
| `crafted` | native statusline and tabline | Onehalf | yes |
| `everforest` | lightline | Everforest | no |
| `zenbones` | lightline | Zenbones | no |

List or select profiles from the repository root:

```sh
./bin/use-profile --list
./bin/use-profile everforest
```

The ignored `profile.local.vim` stores the selection. To try a profile without
changing it, synchronize that profile first and then start Vim with an
environment override:

```sh
./bin/sync-plugins zenbones
VIM_PROFILE=zenbones vim
```

See [Profile, plugin, and theme operations](docs/profiles.md) for precedence,
verification, troubleshooting, and `--no-sync` usage.

## Essential commands

| Command or mapping | Action |
| --- | --- |
| `:VimProfile` | Show the active profile |
| `:ToggleTheme` | Switch between the profile's dark and light themes |
| `<C-P>` | Find files with FZF |
| `:Git` | Open Fugitive's Git summary |
| `<Space>rn` | Rename the current symbol through CoC |
| `<Space>o` | Toggle the CoC outline |

Completion is intentionally manual. Press `<C-Space>` to request it. See the
[CoC and language-server guide](docs/coc-lsp.md) for navigation, diagnostics,
and the complete shared mapping set.

## Maintenance

Synchronize and verify plugins for the selected profile with:

```sh
./bin/sync-plugins
```

Run it after pulling changes to plugin declarations or before switching with
`./bin/use-profile --no-sync PROFILE`.

## License

See [LICENSE](LICENSE). © 2026 [nemron](https://github.com/normenmueller)
