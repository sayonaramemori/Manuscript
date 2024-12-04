-- Be careful about the order of loading
--
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("core.keymappings")
require("core.lazy")

vim.keymap.set("n","g<leader>","viw:Translate ZH<CR>")
