-- Be careful about the order of loading
require("core.keymappings")
require("plugins.lazymanager")
require("plugins.nvimtreesettings")
require("plugins.commenter")

-- Set Neovim theme
require("plugins.mycyberdream")
-- vim.cmd[[colorscheme tokyonight-storm]]

require("plugins.mybufferline")
require("plugins.mytreesitter")
require("plugins.gitsigns")
require("plugins.toggleterm")
require('lualine').setup()

require("plugins.cmp")
require("plugins.lsp")



