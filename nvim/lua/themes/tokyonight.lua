return {
  "folke/tokyonight.nvim",
  -- enabled = false,
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd[[colorscheme tokyonight-moon]]
  end,
}
