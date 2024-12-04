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
    end,
}
