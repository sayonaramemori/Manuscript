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
          )(fname) or vim.fn.getcwd()
        end,
        single_file_support = true,
      }
      lspconfig.pyright.setup{ capabilities = capabilities, }
      lspconfig.rust_analyzer.setup{ capabilities = capabilities, }
      lspconfig.lua_ls.setup{ capabilities = capabilities, }
      lspconfig.volar.setup{ capabilities = capabilities, }
      lspconfig.cmake.setup{ capabilities = capabilities, }
      lspconfig.docker_compose_language_service.setup{ capabilities = capabilities, }
      lspconfig.jsonls.setup{ capabilities = capabilities, }
      lspconfig.grammarly.setup{ capabilities = capabilities, }
      lspconfig.taplo.setup{ capabilities = capabilities, }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        check_outdated_packages_on_open = false,
        icons = {
            package_installed = "@",
            package_pending = "→",
            package_uninstalled = "x",
        },
      },
      pip = {
        ---@since 1.0.0
        -- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
        upgrade_pip = false,

        ---@since 1.0.0
        -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
        -- and is not recommended.
        --
        -- Example: { "--proxy", "https://proxyserver" }
        install_args = {},
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
        "cmake",
        "docker_compose_language_service",
        "jsonls",
        "grammarly",
        "taplo",
      }
    }
  },
}
