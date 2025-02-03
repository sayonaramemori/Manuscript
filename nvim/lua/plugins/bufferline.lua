return {
    'akinsho/bufferline.nvim',
    version = "*",
    lazy = false,
    priority = 500,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    opts =  {
        options = {
            mode = "tabs",
            offsets = {{
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true
            }},
            separator_style = "slant",
            diagnostics = "nvim_lsp",
        }
    }
}
