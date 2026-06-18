local font_inc = 1

if vim.env.TERM == "xterm-kitty" then
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
                opacity = obj.stdout
            end)

            -- vim.system({ "kitten", "@", "set-background-opacity", opacity }, { text = true }, function() end)
            vim.system({ "kitten", "@", "set-background-opacity", 0.5 }, { text = true }, function() end)
            vim.system({ "kitten", "@", "set-font-size", "--", "-" .. font_inc }, { text = true }, function() end)
        end,
    })

    vim.system({ "kitten", "@", "set-background-opacity", 1 }, { text = true }, function() end)
    vim.system({ "kitten", "@", "set-font-size", "--", "+" .. font_inc }, { text = true }, function() end)
end
