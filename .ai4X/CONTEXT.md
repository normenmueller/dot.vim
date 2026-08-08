# Purpose

This file contains durable project understanding for future agents. Current
worktree state, active focus, verification freshness, and next actions belong
only in `.ai4X/STATE.md`.

# Project Summary

This repository is a classic Vim/MacVim configuration for macOS and Linux. It
combines shared editing, navigation, CoC/LSP, FZF, Markdown, Git, and
Haskell behavior with five selectable UI profiles. Evidence: `README.md`,
`vimrc`, `profiles/`.

# Project Objective

Maintain one reliable, understandable Vim configuration whose shared behavior
is changed once while the user can switch UI/theme stacks locally without Git
branch switches. Preserve Vim/MacVim compatibility, exact profile plugin sets,
and safe recovery/verification workflows. This is the stable project purpose;
the immediate task belongs in `.ai4X/STATE.md`.

# Background

The UI configurations previously lived on long-running feature branches,
making shared CoC and language-server fixes repetitive and making `trunk`
appear to be an extra Legacy variant. The accepted redesign moved all variants
into profile
modules on one maintained branch. The old branch tips were preserved as
annotated `archive/*` tags before branch deletion. Evidence: active-session user
decision, Git history, tag names.

The shared CoC workflow uses standard hover, manual completion, and README
documentation. Haskell Language Server remains the only explicitly configured
external language server. Evidence: `vimrc`, `coc-settings.json`, `README.md`.

# Domain Model

- **Profile:** A named UI/plugin configuration in `profiles/`.
- **Selection precedence:** built-in `legacy` default, then ignored
  `profile.local.vim`, then process-local `VIM_PROFILE` override.
- **Persistent switch:** `bin/use-profile` synchronizes and verifies plugins,
  then atomically writes `profile.local.vim`.
- **Temporary switch:** `VIM_PROFILE=PROFILE` selects a profile for one process.
- **Theme mode:** `dark` or `light` within the selected profile; independent of
  the profile name. `:ToggleTheme` changes it for the current session.
- **Plugin-state invariant:** ignored `plugged/` must contain exactly the active
  profile's declared plugins before the setup is considered healthy.
- **Common layer:** shared plugins, mappings, CoC, FZF, markup, editing, and
  development behavior in `vimrc` and common plugin/runtime files.
- **Profile layer:** UI plugins, statusline/tabline choices, NERDTree policy,
  colorscheme adapters, and profile-specific theme data.
- **Canonical agent memory:** `.ai4X/BEHAVIOR.md`, `.ai4X/CONTEXT.md`, and
  `.ai4X/STATE.md`; host-specific files only link to canonical behavior.

Profiles:

| Profile | UI/theme stack | NERDTree |
| --- | --- | --- |
| `legacy` | vim-airline + Onehalf | yes |
| `lightline` | lightline + Onehalf | yes |
| `crafted` | native statusline/tabline + Onehalf | yes |
| `everforest` | lightline + Everforest | no |
| `zenbones` | lightline + Zenbones compatibility mode | no |

# Repository Map

- `vimrc`: selector precedence, conditional plugin declarations, shared config,
  profile sourcing, platform theme initialization.
- `profiles/*.vim`: five profile-specific UI and theme modules.
- `autoload/nemprofile.vim`: shared Lightline, NERDTree, native UI, and theme
  construction helpers.
- `autoload/nemui.vim`: Crafted profile native statusline/tabline functions.
- `autoload/tglthm.vim`: generic dark/light theme application and resolution.
- `plugin/tglthm.vim`: user command integration for theme toggling.
- `bin/use-profile`: validated persistent profile switch.
- `bin/sync-plugins`: install-before-clean synchronization and health gates.
- `coc-settings.json`: CoC language server configuration.
- `README.md`: concise human quick start, profile overview, and essential use.
- `LICENSE`: canonical Apache License 2.0 text sourced from GitHub's license
  template.
- `docs/`: detailed human profile/plugin/theme and CoC/language-server guides.
- `plugin/`, `syntax/`, `spell/`, `doc/`: classic Vim runtime content.
- `.ai4X/`: canonical agent behavior, context, and volatile state memory.
- `AGENTS.md`: workspace-agent adapter to `.ai4X/BEHAVIOR.md`.
- `.github/agents/vim.agent.md`: Copilot CLI adapter to
  `.ai4X/BEHAVIOR.md`.
- `plugged/`, `profile.local.vim*`, `tmp/`: ignored local runtime state.

# Architecture And Design

`vimrc` resolves the configuration directory and profile before invoking
vim-plug. It validates profile names from existing `profiles/*.vim`, declares
common plugins plus the selected UI stack, calls `plug#end()`, and then sources
the selected profile before Vim's normal plugin pass. This permits profiles to
set plugin globals while keeping plugin discovery conditional.

Profiles use autoload helpers rather than duplicating shared Lightline,
NERDTree, and terminal/fold theme definitions. `tglthm#apply()` consumes the
selected profile's `g:tglthm_profiles`, coordinates colorscheme/background,
Airline or Lightline refresh, native highlights, folded highlighting, and
terminal ANSI colors. macOS startup follows `AppleInterfaceStyle`; other
systems follow `&background`.

`bin/use-profile` validates against actual profile files. With default sync it
runs `bin/sync-plugins` before atomically persisting selection, so a failed new
profile does not replace the chosen profile. `bin/sync-plugins` installs before
cleaning, tolerates vim-plug's cosmetic non-zero status only when `PlugStatus`
and CoC/fzf artifacts prove health, and then returns a meaningful result.

# User Preferences

- Chat in German; write these canonical bootstrap artifacts in English.
  Evidence: explicit user instruction in the active session.
- Execute agreed plans carefully, correctly, and completely; do not stop at a
  proposal when authorized to implement. Evidence: active-session request.
- Act as a critical expert peer and seek independent specialist review when the
  user requests it. Evidence: active-session request and completed review.
- Give concise practical onboarding after structural workflow changes.
  Evidence: active-session request about profile/theme usage.
- Favor a logical profile workflow over checking out Git branches to change the
  active Vim UI. Evidence: accepted redesign in the active session.

# Constraints

- Classic Vim/MacVim is the compatibility target; Neovim-only assumptions are
  invalid unless explicitly scoped as an experiment.
- Plugin management is through vim-plug and may require network access when a
  selected plugin is missing.
- `everforest` and `zenbones` intentionally use query-driven navigation without
  NERDTree.
- `profile.local.vim` and `plugged/` are local machine state, not repository
  configuration.
- Theme and statusline behavior spans several components; partial edits can
  produce a visually inconsistent but syntactically valid Vim startup.
- No repository-wide automated CI, Vimscript linter, or formatter is established.

# Non-Goals

- Do not migrate to Neovim, Lua-first configuration, or Neovim-only UI plugins
  without an explicit user request.
- Do not restore one UI variant per Git branch.
- Do not commit plugin checkouts or local profile selection.
- Do not make every profile share NERDTree or the same statusline.
- Do not turn `.ai4X/` into human-facing usage documentation or a chronological
  activity log.

# External Context

Observed external dependencies include vim-plug-managed GitHub plugins such as
CoC, FZF, Lightline, Airline, Onehalf, Everforest, Zenbones, NERDTree,
vim-markdown, Fugitive, and Hindent. The remote repository is
`normenmueller/dot.vim`.
Evidence: `vimrc`, Git remote observed in the active session.

No external web research was used for this bootstrap update. Plugin API/version
claims beyond repository behavior are therefore UNVERIFIED.

The repository is distributed under Apache License 2.0. The canonical license
text was obtained from GitHub's `licenses/apache-2.0` API template. Evidence:
`LICENSE`, explicit user decision on 2026-07-17.
