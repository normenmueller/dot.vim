# Profiles, Plugins, and Themes

## Profile selection

All maintained configurations live on `trunk`. Vim resolves the active profile
in this order, with the last applicable source winning:

1. Built-in fallback: `legacy`.
2. Local selection: `profile.local.vim`.
3. Process override: `VIM_PROFILE`.

`profile.local.vim` is ignored by Git. Select a profile persistently from the
repository root:

```sh
./bin/use-profile lightline
```

The script synchronizes and verifies the profile's plugins before atomically
updating the local selection. List the available profiles with:

```sh
./bin/use-profile --list
```

Use `--no-sync` only when synchronization will be performed separately:

```sh
./bin/use-profile --no-sync crafted
./bin/sync-plugins
```

For a temporary profile, synchronize its plugin set before starting Vim:

```sh
./bin/sync-plugins zenbones
VIM_PROFILE=zenbones vim
```

Inside Vim, `:VimProfile` prints the active profile.

## Plugin synchronization

`bin/sync-plugins` accepts an optional profile name. It runs `PlugInstall`,
removes plugins unused by that profile with `PlugClean`, checks `PlugStatus`,
and verifies the CoC build artifact and FZF executable.

```sh
./bin/sync-plugins
./bin/sync-plugins everforest
```

Because profiles have different plugin sets, synchronize before launching a
profile that has not been used locally.

## Theme switching

Each profile defines paired dark and light theme settings. `:ToggleTheme`
switches between them for the current Vim process. On macOS, startup follows
the system interface style; elsewhere it starts from Vim's current
`background` setting.

## Troubleshooting

The configuration installs vim-plug automatically when it is missing. This
requires `curl` and network access. If automatic installation fails, install it
manually and rerun the synchronization command:

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
./bin/sync-plugins
```

If synchronization fails, inspect its `PlugStatus` output. Also confirm that
Node.js and npm are available for CoC and that the selected profile name appears
in `./bin/use-profile --list`.
