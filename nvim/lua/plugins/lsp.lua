return {
  {
    "neovim/nvim-lspconfig", 
    dependencies = "hrsh7th/cmp-nvim-lsp",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      local util = require 'lspconfig.util'
      lspconfig.clangd.setup{
        capabilities = capabilities,
        root_dir = function(fname)
          return util.root_pattern(
            'CMakeLists.txt',
            '.clangd',
            '.clang-tidy',
            '.clang-format',
            'compile_commands.json',
            'compile_flags.txt',
            'configure.ac' -- AutoTools
          )(fname) or  vim.fn.getcwd()
        end,
        single_file_support = true,
      }
      lspconfig.pyright.setup{ capabilities = capabilities, }
      lspconfig.rust_analyzer.setup{ capabilities = capabilities, }
      lspconfig.lua_ls.setup{ capabilities = capabilities, }
      lspconfig.volar.setup{ capabilities = capabilities, }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
            package_installed = "@",
            package_pending = "→",
            package_uninstalled = "x",
        },
      },
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "pyright",
        "rust_analyzer",
        "lua_ls",
        "volar",
      }
    }
  },
}
