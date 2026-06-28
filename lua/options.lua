vim.g.mapleader = " "

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.wrap = false
vim.opt.textwidth = 80

vim.opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"

vim.opt.spelllang = 'en_gb'
vim.opt.spell = true

vim.opt.winborder = "rounded"
