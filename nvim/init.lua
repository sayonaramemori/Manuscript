-- Be careful about the order of loading
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Dynamically load the configuration
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/restore-position.vim')

require("core.keymappings")
require("core.lazy")

