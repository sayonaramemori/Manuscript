return {
  'stevearc/aerial.nvim',
  -- Optional dependencies
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("aerial").setup({
      close_automatic_events = {'switch_buffer'},
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        layout = {
          min_width = 10,
          -- Enum: prefer_right, prefer_left, right, left, float
          default_direction = "prefer_left",
          -- Determines where the aerial window will be opened
          --   edge   - open aerial at the far right/left of the editor
          --   window - open aerial to the right/left of the current window
          placement = "window",
          -- When the symbols change, resize the aerial window (within min/max constraints) to fit
          resize_to_content = true,
          -- Preserve window size equality with (:help CTRL-W_=)
          preserve_equality = false,
        },
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    })
    vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
  end,
}
