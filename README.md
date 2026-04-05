# Vim / Neovim Configuration

My personal, highly optimized Neovim configuration focused on web development with full LSP support.

## Features
- **Colorscheme**: Catppuccin Mocha (dark, easy on the eyes)
- **File Explorer**: nvim-tree with icons
- **Fuzzy Finder**: Telescope (files, grep, buffers)
- **Syntax Highlighting**: Treesitter (JS, TS, TSX, Lua, Python, Rust, Go…)
- **LSP**: Mason + nvim-lspconfig (`ts_ls`, `pyright`, `lua_ls`, `cssls`, `html`)
- **Completion**: nvim-cmp with LSP + buffer + path + snippets
- **Status Line**: lualine (Catppuccin theme)
- **Git**: gitsigns
- **Extras**: autopairs, comment toggle, bufferline, indent guides

## Requirements
- Neovim >= 0.9
- Git
- Node.js (for ts_ls, cssls)
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal

## Installation
```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this config
git clone https://github.com/ilhamfachrudin/vim-configuration ~/.config/nvim

# Open Neovim — lazy.nvim will auto-install all plugins
nvim
```

## Key Bindings
| Key | Action |
|-----|--------|
| `<Space>e` | Toggle file explorer |
| `<Space>ff` | Find files (Telescope) |
| `<Space>fg` | Live grep (Telescope) |
| `<Space>fb` | Browse buffers |
| `gd` | Go to definition |
| `K` | Hover docs |
| `<Space>rn` | Rename symbol |
| `<Space>ca` | Code actions |
| `<Space>f` | Format file |
| `<Shift+h/l>` | Previous/next buffer |
| `<Space>bd` | Delete buffer |
| `<Space>w` | Save |
| `<Space>q` | Quit |
| `<Ctrl+h/j/k/l>` | Navigate windows |

## Structure
```
~/.config/nvim/
└── init.lua       ← Single-file config with lazy.nvim
```

## Author
**Xeran** — [github.com/ilhamfachrudin](https://github.com/ilhamfachrudin)
