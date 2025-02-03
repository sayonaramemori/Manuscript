return {
    'hedyhli/outline.nvim',
    config = function()
      require('outline').setup({
        providers = {
          priority = { 'lsp', 'coc', 'markdown', 'norg', 'treesitter' },
        },
      })
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
    end,
    event = "VeryLazy",
    dependencies = {
      'epheien/outline-treesitter-provider.nvim'
    }
}
