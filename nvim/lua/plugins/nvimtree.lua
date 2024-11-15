-- Auto close when exiting
vim.api.nvim_create_autocmd({"QuitPre"}, {
    callback = function() vim.cmd("NvimTreeClose") end,
})

-- Global toggle key
vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeToggle<cr>", {silent = true, noremap = true})

local function open_tab_with_tree(node)
  local api = require("nvim-tree.api")
  api.node.open.tab(node)
  api.tree.toggle({ focus = false, find_file = true, })
end

local function on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  vim.keymap.set('n', 's', api.node.open.vertical,                    opts('Open: Vertical Split'))
  vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.tab,                         opts('Open: New Tab'))
  -- vim.keymap.set('n', 'o', open_tab_with_tree,                         opts('Open: New Tab'))
  vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
  vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
  vim.keymap.set('n', '.',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
end

local function open_nvim_tree(data)
  require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
end 


return {
  "nvim-tree/nvim-tree.lua",
   version = "*",
   lazy = false,
   dependencies = {
     "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      on_attach = on_attach,
      tab = {
        sync = {
          open = true,
        }
      },
      sort = {
          sorter = "filetype",
      },
      view = {
          width = 25,
          side = "right",
          number = false,
      },
      renderer = {
          group_empty = true,
      },
      filters = {
          dotfiles = true,
      },
    }
    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
  end,
}
