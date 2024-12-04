-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- vim.opt.cursorline = true  
vim.opt.hlsearch = false
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Encoding and History
vim.opt.encoding = "UTF-8"
vim.opt.history = 50  -- Uncomment if you want to set history length

-- Tabs and Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Terminal color
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Command Bar
-- vim.opt.laststatus = 2  -- Uncomment if you want a constant status line
-- vim.opt.cmdheight = 2
vim.opt.autochdir = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.ruler = true

-- Menus and Indentation
vim.opt.wildmenu = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Display Characters and Scrolling
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "▫" }
vim.opt.scrolloff = 5

-- Timing
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 100

-- Syntax and Filetype
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")


-- Set <leader> as ;
vim.g.mapleader = ";"

-- Resize splits with arrow keys
vim.keymap.set("n", "<right>", ":vertical resize +5<CR>")
vim.keymap.set("n", "<left>", ":vertical resize -5<CR>")

vim.keymap.set("i", "<leader><leader>", "<Esc>")
vim.keymap.set("n", "Y", "y$")

-- Tab management
vim.keymap.set("n", "H", ":-tabnext<CR>")
vim.keymap.set("n", "L", ":+tabnext<CR>")

-- Move between splits
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>l", "<C-w>l")

-- Save and quit
vim.keymap.set("n", "<leader>w", ":wq<CR>")

-- Operating Vim on Windows
vim.keymap.set("n", "<leader>v", "<C-v>")
vim.keymap.set("n", "a", "A")

-- Plugin and utility commands
vim.keymap.set("i", "{", "{<CR><CR>}<ESC>kcc")
vim.keymap.set("i", "[", "[]<ESC>i")

-- Additional mappings
vim.keymap.set("n", "[", "0")
vim.keymap.set("n", "s", ":w<cr>")
vim.keymap.set("n", "]", "$")
vim.keymap.set("n", "K", "i<cr><Esc>")
vim.keymap.set("n", "<leader>b", ":checkhealth lsp<cr>")


