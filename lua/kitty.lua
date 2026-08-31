local bg, opacity

local fs = 14

if vim.env.KITTY_WINDOW_ID and !vim.g.neovide then
    vim.system({ "kitten", "@", "ls" }, { text = true }, function(res)
        local windows = vim.json.decode(res.stdout)
        if #windows == 1 then
            opacity = windows[1].background_opacity
        end
    end)

    vim.system({ "kitten", "@", "get-colors" }, { text = true }, function(obj)
        for line in obj.stdout:gmatch("[^\r\n]+") do
            local color = line:match("^background%s+(%S+)")
            if color then bg = color end
        end
    end)

    vim.system({ "kitten", "@", "set-background-opacity", "1" }, { text = true }, function() end)
    vim.system({ "kitten", "@", "set-font-size", "--", tostring(fs) }, { text = true }, function() end)
    vim.system({ "kitten", "@", "set-color", "background=" .. string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).bg) }, { text = false }, function() end)

    vim.api.nvim_create_autocmd('VimLeavePre', { callback = function()
        -- these should be vim.uv.spawn() calls w/ { detached = true }
        vim.system({ "kitten", "@", "set-background-opacity", opacity }, { text = true }, function() end)
        vim.system({ "kitten", "@", "set-font-size", "--", "0" }, { text = true }, function() end)
        vim.system({ "kitten", "@", "set-color", "background=" .. bg }, { text = false }, function() end)
    end})

    vim.api.nvim_create_autocmd("ColorScheme", { callback = function()
            vim.system({ "kitten", "@", "set-color", "background=" .. string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).bg) }, { text = false }, function() end)
        end,
    })
end
