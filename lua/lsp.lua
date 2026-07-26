vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/saghen/blink.lib",
    "https://github.com/saghen/blink.compat",
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
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    cmdline = {
        completion = {
            list = { selection = { preselect = false } },
            menu = { auto_show = true },
        },
    },
    snippets = {
        preset = "default",
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer", "omni" },
    }
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

-- Enable LSP Folds if available
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Check if the server supports folding ranges
    if client and client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()

      -- Enable LSP-managed folding
      vim.wo[win].foldmethod = "expr"
      vim.wo[win].foldexpr = "v:lua.vim.lsp.foldexpr()"

      -- Keep folds open by default when entering a file
      -- vim.wo[win].foldlevel = 99
    end
  end,
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
