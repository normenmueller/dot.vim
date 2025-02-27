# nemron's Vim Configuration

Inspired by [Derek Wyatt's Vim Configuration](https://github.com/derekwyatt/vim-config)

## 🛠 My Ultimate Vim Configuration

This `.vimrc` is designed for **modern, efficient, and intuitive Vim usage**, particularly on **macOS**. It provides an excellent balance between usability, performance, and extensibility.

## ✨ Features

### 🔹 **Plugin Management with `vim-plug`**

- Automatically installs `vim-plug` if missing.
- Well-structured plugin organization.

### 🔹 **Navigation & Usability Enhancements**

- **Smooth cursor movement** within wrapped lines (`<C-j>` / `<C-k>`).
- **Fuzzy file searching** with CtrlP (or optional `fzf`).
- **NERDTree** for efficient file navigation.

### 🔹 **Developer-friendly setup**

- **Full `coc.nvim` integration** with:
  - `<C-n>` / `<C-p>` for navigation.
  - `<Tab>` / `<CR>` for selection (with space auto-insertion).
- **Haskell support** (`vim-hindent`, `haskell-vim`).
- **Auto spellcheck for Git commits.**

### 🔹 **MacOS-specific improvements**

- **Dark/light mode detection** with `ToggleTheme()`.
- **Auto-create swap & undo directories** (`~/.vim/tmp/`).

### 🔹 **GUI & Visual Improvements**

- **True color support** (`termguicolors`).
- **Powerful status bar** with `vim-airline`.
- **Consistent cursor styles in different modes.**

---

## 🚀 Installation

To install it, do the following:

* Wipe out your `~/.vimrc` file and `~/.vim` directory (back up if you wish)
* `git clone https://github.com/normenmueller/dot.vim.git ~/.vim`
* `ln -s ~/.vim/vimrc ~/.vimrc`
* Start Vim
* `:PlugInstall` to install Vim bundles via [vim-plug](https://github.com/junegunn/vim-plug)

### **Ensure `vim-plug` is installed**

Vim will install it automatically, but you can also run:
```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

---

## 🔧 Optional Configurations

### **1️⃣ Use `fzf` instead of CtrlP**

Uncomment these lines in `.vimrc`:

```vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
```

### **2️⃣ Auto-close NERDTree on file open**

Set this option:

```vim
let g:NERDTreeQuitOnOpen = 1
```

### **3️⃣ Auto-organize imports on save (for CoC users)**

```vim
autocmd BufWritePost * silent! call CocAction('runCommand', 'editor.action.organizeImport')
```

---

## 🎯 Why Use This `.vimrc`?

✅ **Minimal, yet powerful.**
✅ **MacOS-optimized.**
✅ **Intuitive autocomplete & navigation.**
✅ **Easy to extend & modify.**

🚀 **Give it a try and supercharge your Vim experience!** 🚀

