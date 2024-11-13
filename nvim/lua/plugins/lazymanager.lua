-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
--[[     {
          "iamcco/markdown-preview.nvim",
          cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
          build = "cd app && npm install",
          init = function()
            vim.g.mkdp_filetypes = { "markdown" }
          end,
          ft = { "markdown" },
    }, ]]
    {
        "nvim-tree/nvim-tree.lua",
         version = "*",
         lazy = false,
         dependencies = {
           "nvim-tree/nvim-web-devicons",
         },
--         config = function()
--            require("nvim-tree").setup {}
--         end,
    },
    {
        "nvim-lualine/lualine.nvim",
         dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
         "scottmckendry/cyberdream.nvim",
         lazy = false,
         priority = 1000,
    },
    {   
         'akinsho/bufferline.nvim', 
         version = "*", 
         dependencies = 'nvim-tree/nvim-web-devicons',
    },
    {
        "nvim-treesitter/nvim-treesitter",
    },
    -- cmp plugins
    {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    {
        "neovim/nvim-lspconfig",    --enable LSP
        "williamboman/mason.nvim",  --LSP Manager
        "williamboman/mason-lspconfig.nvim",
    }, 
    {
        'numToStr/Comment.nvim',
    },
    {
        "lewis6991/gitsigns.nvim",
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {'akinsho/toggleterm.nvim', version = "*", config = true},
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

