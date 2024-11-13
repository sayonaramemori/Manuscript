require("toggleterm").setup({
    -- size can be a number or function which is passed the current terminal
    size = 20, 
    open_mapping = [[<c-t>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
    direction = 'float',
    shade_terminals = true,
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})


