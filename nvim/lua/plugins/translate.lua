return {
    'uga-rosa/translate.nvim', 
    config = function()
        require("translate").setup({
            preset = {
                output = {
                    split = {
                        append = true,
                    },
                },
            },
        })
        -- Hello World
        vim.keymap.set("n","g<leader>",":Translate zh-CN<CR>")
    end,
}
