local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

vim.lsp.config('markdown_oxide', {
    cmd = { 'markdown-oxide' },
    filetypes = { 'markdown' },
    root_markers = { '.git', '.obsidian', '.moxide.toml' },
    capabilities = capabilities,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= "markdown_oxide" then
            return
        end
        if vim.fn.exists(":Daily") == 0 then
            vim.api.nvim_create_user_command("Daily", function(cmd_args)
                local target = cmd_args.args ~= "" and cmd_args.args or "today"
                client:exec_cmd({command="jump", arguments={target}})
            end, { desc = "Open daily note", nargs = "*" })
        end
    end
})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

vim.lsp.enable('markdown_oxide')
