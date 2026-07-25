vim.keymap.set('n', "<Leader>e", "<cmd>Neotree toggle<cr>")
vim.keymap.set('n', "<leader>Q", "<cmd>qall<cr>")
vim.keymap.set('n', "<leader>u", "<cmd>Undotree<cr>")
vim.keymap.set('n', "<leader>z", "<cmd>ZenMode<cr>")
vim.keymap.set('n', "<leader>p", require("precognition").peek, { desc = "Show line jumps" })
vim.keymap.set('n', "<leader>h", "<cmd>Hardtime toggle<cr>")
vim.keymap.set('n', "<leader>g", require('neogit').open, { desc = "Open Neogit UI" })

vim.keymap.set('n', "<leader>s", function()
    if vim.o.signcolumn == "no" then
        vim.o.signcolumn = "yes:1"
    else
        vim.o.signcolumn = "no"
    end
end, { desc = "Show signcolumn" })

local function insert_lines(dir, count)
    local row = vim.api.nvim_win_get_cursor(0)[1]

    local lines = {}
    for _ = 1, count do
        lines[#lines + 1] = ""
    end

    if dir == "below" then
        vim.api.nvim_put(lines, "l", true, true)
        vim.api.nvim_win_set_cursor(0, { row + count, 0 })
    else
        vim.api.nvim_put(lines, "l", false, true)
        vim.api.nvim_win_set_cursor(0, { row, 0 })
    end

    vim.cmd.startinsert()
end

-- shared operatorfunc
local function operator_insert_lines(_)
    local dir = vim.g._insert_dir
    insert_lines(dir, vim.v.count1)
end

_G.operator_insert_lines = operator_insert_lines

local function trigger_insert(dir)
    vim.g._insert_dir = dir
    vim.o.operatorfunc = "v:lua.operator_insert_lines"
    return "g@l"
end

vim.keymap.set("n", "o", function()
    return trigger_insert("below")
end, { expr = true, noremap = true, silent = true })

vim.keymap.set("n", "O", function()
    return trigger_insert("above")
end, { expr = true, noremap = true, silent = true })

-- some random lazyvim up/down magic
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Move Lines
-- Stolen from lazyvim look at this magic lmao
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- better indenting
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")


vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete Buffer" })

-- disable <shift> jk
vim.keymap.set("n", "<S-j>", "")
-- vim.keymap.del("n", "<S-j>")

-- convert ::: to ∴
vim.cmd("iabbrev ::: ∴")
vim.cmd("iabbrev :d Δ")
