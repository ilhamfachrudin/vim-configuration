-- ============================================================
--   Xeran's Neovim Config — init.lua
--   github.com/ilhamfachrudin
-- ============================================================

-- [[ Options ]]
local opt = vim.opt
opt.number         = true
opt.relativenumber = true
opt.tabstop        = 2
opt.shiftwidth     = 2
opt.expandtab      = true
opt.smartindent    = true
opt.wrap           = false
opt.cursorline     = true
opt.termguicolors  = true
opt.signcolumn     = "yes"
opt.updatetime     = 150
opt.scrolloff      = 8
opt.sidescrolloff  = 8
opt.hlsearch       = false
opt.incsearch      = true
opt.ignorecase     = true
opt.smartcase      = true
opt.splitbelow     = true
opt.splitright     = true
opt.undofile       = true
opt.clipboard      = "unnamedplus"
opt.completeopt    = { "menuone", "noselect" }

-- [[ Leader ]]
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- [[ Bootstrap lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require("lazy").setup({

  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "mocha" })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({ view = { width = 30 } })
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
    end,
  },

  -- Treesitter (syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "javascript", "typescript", "tsx",
          "html", "css", "json", "yaml", "markdown",
          "python", "rust", "go",
        },
        highlight = { enable = true },
        indent    = { enable = true },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "lua_ls", "pyright", "cssls", "html" },
      })
      local lsp = require("lspconfig")
      local on_attach = function(_, buf)
        local map = function(k, f) vim.keymap.set("n", k, f, { buffer = buf }) end
        map("gd", vim.lsp.buf.definition)
        map("K",  vim.lsp.buf.hover)
        map("<leader>rn", vim.lsp.buf.rename)
        map("<leader>ca", vim.lsp.buf.code_action)
        map("<leader>f",  vim.lsp.buf.format)
      end
      for _, server in ipairs({ "ts_ls", "lua_ls", "pyright", "cssls", "html" }) do
        lsp[server].setup({ on_attach = on_attach })
      end
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(a) require("luasnip").lsp_expand(a.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping.select_next_item(),
          ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({ options = { theme = "catppuccin" } })
    end,
  },

  -- Git integration
  { "lewis6991/gitsigns.nvim", config = true },

  -- Auto pairs
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },

  -- Comment toggle
  { "numToStr/Comment.nvim", config = true },

  -- Buffer tabs
  { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true },

  -- Indentation guides
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", config = true },
})

-- [[ Keymaps ]]
local map = vim.keymap.set

-- File explorer
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

-- Telescope
local ts = require("telescope.builtin")
map("n", "<leader>ff", ts.find_files)
map("n", "<leader>fg", ts.live_grep)
map("n", "<leader>fb", ts.buffers)

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<CR>")
map("n", "<S-l>", "<cmd>bnext<CR>")
map("n", "<leader>bd", "<cmd>bdelete<CR>")

-- Save / Quit
map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>q<CR>")
map("n", "<leader>Q", "<cmd>qa!<CR>")

-- Indent with Tab in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines up/down
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Clear search
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
