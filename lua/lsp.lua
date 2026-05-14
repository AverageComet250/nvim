vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/windwp/nvim-ts-autotag",
    "https://github.com/folke/todo-comments.nvim",
})

vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Completion menu options
vim.opt.conceallevel = 0 -- Show all text normally (no concealment)

require("mason").setup()
require("mason-lspconfig").setup()
require("blink.cmp").setup({
    keymap = {
        preset = "enter",
    },
    fuzzy = {
        implementation = "prefer_rust",
        prebuilt_binaries = {
            force_version = "v*"
        }
    },
})

require("todo-comments").setup({
    signs = false
})
require("nvim-autopairs").setup()
require("nvim-ts-autotag").setup({
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true
    }
})
-- The following was made by chat lmao
-- Enable LSP diagnostics (Inline error messages)
vim.diagnostic.config({
  virtual_text = true,  -- Show inline errors
  signs = false,         -- Show signs in the gutter
  underline = true,     -- Underline errors/warnings
  update_in_insert = false, -- Don't update diagnostics while typing
  severity_sort = true  -- Sort diagnostics by severity
})
