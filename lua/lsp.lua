vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/saghen/blink.lib",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/windwp/nvim-ts-autotag",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/kuri-sun/todoage.nvim"
})

vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Completion menu options
vim.opt.conceallevel = 0 -- Show all text normally (no concealment)

require("mason").setup()
require("mason-lspconfig").setup()
local cmp = require("blink.cmp")
cmp.build():wait(60000)
cmp.setup({
    keymap = {
        preset = "enter",
        ["<Tab>"] = { 'select_next', 'snippet_forward', 'fallback'},
        ["<S-Tab>"] = { 'select_prev', 'snippet_backward', 'fallback'},
    },
})

require("todo-comments").setup({
    signs = false,
    highlight = {
        comments_only = false
    }
})
require("nvim-autopairs").setup()
require("nvim-ts-autotag").setup({
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true
    }
})

vim.lsp.codelens.enable()

-- The following was made by chat lmao
-- Enable LSP diagnostics (Inline error messages)
vim.diagnostic.config({
  virtual_text = true,  -- Show inline errors
  signs = false,         -- Show signs in the gutter
  underline = true,     -- Underline errors/warnings
  update_in_insert = false, -- Don't update diagnostics while typing
  severity_sort = true  -- Sort diagnostics by severity
})

vim.lsp.config('harper_ls', {
  settings = {
    ["harper-ls"] = {
      dialect = "British",
    },
  },
})
