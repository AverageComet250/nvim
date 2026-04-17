vim.pack.add({
    "https://github.com/folke/zen-mode.nvim",
    "https://github.com/folke/twilight.nvim"
})

require("zen-mode").setup({
    windows = {
        backdrop = 1,
        width = 0
    },
    plugins = {
        kitty = {
            enabled = true,
            font = "13"
        },
        todo = {
            enabled = true
        },
    }
})

-- TODO: full width zen mode
