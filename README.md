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
- **File and buffer navigation** via `fzf` (`<C-P>`, `:Buffers`) instead of a file-tree sidebar.
- **Always-visible tabline** with clear active tab highlighting.

### 🔹 **Language and Linting Support**

- **LSP support via `coc.nvim`**, preconfigured with defaults.
- **Syntax highlighting** for common languages (e.g. Haskell).
- **Autoformatting** on save where configured.

### 🔹 **Git Integration**

- Git commands via `vim-fugitive` (e.g. `:Gstatus`, `:Gdiff`, etc.).

### 🔹 **UI & Visual Improvements**

- **True color** and `termguicolors`.
- **`lightline.vim`** for a lean configurable statusline/tabline.
- **Everforest** for a calm readable Vim colorscheme.
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

Ensure `vim-plug` is available. If not:

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

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
