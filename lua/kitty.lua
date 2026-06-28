local font_inc = 1

-- TODO: use vim.g.terminal_color_* where possible, as well as other global vars

if vim.env.TERM == "xterm-kitty" then
    local termbg
    vim.system({
        "kitten", "@", "get-colors"
    }, { text = true }, function(obj)
        for line in obj.stdout:gmatch("[^\r\n]+") do
            local color = line:match("^background%s+(%S+)")
            if color then termbg = color end
        end
    end)


    vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
            local opacity
            vim.system({
              "rg",
              "^background_opacity\\s+([0-9.]+)",
              "-r",
              "$1",
              vim.fn.expand("~/.config/kitty/kitty.conf"),
            }, { text = true }, function(obj)
            end)

            -- vim.system({ "kitten", "@", "set-background-opacity", opacity }, { text = true }, function() end)
            vim.system({ "kitten", "@", "set-background-opacity", 0.5 }, { text = true }, function() end)
            vim.system({ "kitten", "@", "set-font-size", "--", "-" .. font_inc }, { text = true }, function() end)
            vim.system({ "kitten", "@", "set-color", "background=" .. termbg }, { text = false }, function() end)
        end,
    })

    local bg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).bg)

    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
            bg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).bg)

            vim.system({ "kitten", "@", "set-color", "background=" .. bg }, { text = false }, function() end)
        end,
    })

    vim.system({ "kitten", "@", "set-background-opacity", 1 }, { text = true }, function() end)
    vim.system({ "kitten", "@", "set-font-size", "--", "+" .. font_inc }, { text = true }, function() end)
    vim.system({ "kitten", "@", "set-color", "background=" .. bg }, { text = false }, function() end)
end
