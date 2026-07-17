# nemron's Vim Configuration

Inspired by [Derek Wyatt's Vim Configuration](https://github.com/derekwyatt/vim-config)

## 🛠 My Ultimate Vim Configuration

This `.vimrc` is designed for **modern, efficient, and intuitive Vim usage**, particularly on **macOS/Linux**. It balances minimalism with developer-friendly features and practical defaults.

## ✨ Features

### 🔹 **Plugin Management with `vim-plug`**

- Automatically installs `vim-plug` if missing.
- Plugins grouped by function: language support, UI, navigation, completion, etc.

### 🔹 **Navigation & Usability Enhancements**

- **Wrapped line navigation** via `<C-j>` / `<C-k>`.
- **Quick file opening** with `<C-P>` via `fzf`.
- **Buffer switching** with `:ls`, aliased to `:Buffers`.
- **File tree navigation** with `NERDTree`, toggleable via `<Leader>d`; locate the current file with `<Leader>f`.
- **Tab navigation** and visual enhancements.

### 🔹 **Language and Linting Support**

- **LSP support via `coc.nvim`**, preconfigured with defaults.
- **Syntax highlighting** for common languages (e.g. Haskell).
- **Autoformatting** on save where configured.

### 🔹 **Git Integration**

- Git commands via `vim-fugitive` (e.g. `:Gstatus`, `:Gdiff`, etc.).

### 🔹 **UI & Visual Improvements**

- **True color** and `termguicolors`.
- **`vim-airline`** for an informative and aesthetic statusline.
- **Customizable theme** with support for light/dark switching via `:ToggleTheme`.
- **Consistent cursor styles** per mode.

### 🔹 **System Integration**

- **macOS clipboard support**.
- **Automatic undo/swap/backup directories** under `~/.vim/tmp/`.

---

## 🚀 Installation

```sh
# Backup existing config
mv ~/.vimrc ~/.vimrc.bak
mv ~/.vim ~/.vim.bak
```

Clone the repo

```sh
git clone https://github.com/normenmueller/dot.vim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
```

Open Vim and install plugins

```
vim +PlugInstall +qall
```

Keep the local plugin checkout in sync with the current branch

```sh
./bin/sync-plugins
```

Ensure `vim-plug` is available. If not:

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## 📝 CoC and Marksman Workflow

The CoC mappings are shared across configured language servers. In Markdown and
Pandoc buffers, Marksman provides link navigation, heading symbols, references,
diagnostics, completion, rename support, and hover information.

| Mapping | Action |
| --- | --- |
| `<C-Space>` | Request completion for links and headings |
| `gd` | Open the link target |
| `gr` | Find references to the current heading or link |
| `<Space>rn` | Rename a heading and update its references |
| `<Space>o` | Toggle the document outline |
| `<Space>s` | Search workspace symbols |
| `[g` / `]g` | Move between diagnostics |
| `<Space>a` | Open the complete diagnostics list |
| `K` | Show hover information for the current link |

Completion is intentionally manual because `suggest.autoTrigger` is set to
`none`. Use `:CocDiagnostics` as an alternative diagnostics view.

Marksman uses the nearest `.marksman.toml` or `.git/` marker as the workspace
root. Add `.marksman.toml` to a Markdown knowledge base when it should form an
independent workspace.

---

## 🔧 Optional Configurations

### **Automatically organize imports (CoC)**

```vim
autocmd BufWritePost * silent! call CocAction('runCommand', 'editor.action.organizeImport')
```

---

## 🎯 Why Use This `.vimrc`?

- ✅ **Minimal but practical**: avoids bloat while enabling modern dev workflows.
- ✅ **macOS/Linux friendly**: clipboard, paths, and shell integration.
- ✅ **Modular and extensible**: easy to add or remove plugins.
- ✅ **Great UX**: wrapped lines, color support, buffer switching, etc.

🚀 Try it and enjoy a cleaner, more powerful Vim! 🚀
