vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
        if not ev.data.activate then vim.cmd.packadd("nvim-treesitter") end
        vim.cmd("TSUpdate")
    end
end })

vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter"
})

local languages = {
    "python",
    "rust",
    "zsh",
    "c",
    "cmake",
    "markdown",
    "markdown_inline",
    "regex",
    "html",
    "typst",
    "rust",
    "javascript",
    -- required languages
    "lua",
    "vim",
    "vimdoc",
    "c",
    "query"
}

require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd('FileType', {
    pattern = languages,
    callback = function()
        vim.treesitter.start()

        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
})
