local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

vim.lsp.config('markdown_oxide', {
    cmd = { 'markdown-oxide' },
    filetypes = { 'markdown' },
    root_markers = { '.git', '.obsidian', '.moxide.toml' },
    capabilities = capabilities,
})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

vim.lsp.enable('markdown_oxide')
