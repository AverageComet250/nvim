vim.pack.add({
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/jay-babu/mason-nvim-dap.nvim",
    "https://github.com/thehamsta/nvim-dap-virtual-text"
})

local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

-- Dap Virtual Text
dap_virtual_text.setup()

mason_dap.setup({
    ensure_installed = { "cppdbg", "node2", "python" },
	automatic_installation = true,
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,
	},
})

-- Configurations
dap.configurations = {
	c = {
		{
			name = "Launch file",
			type = "cppdbg",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopAtEntry = false,
			MIMode = "lldb",
		},
		{
			name = "Attach to lldbserver :1234",
			type = "cppdbg",
			request = "launch",
			MIMode = "lldb",
			miDebuggerServerAddress = "localhost:1234",
			miDebuggerPath = "/usr/bin/lldb",
			cwd = "${workspaceFolder}",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
		},
	},
    python = {
		{
			-- The first three options are required by nvim-dap
			type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
			request = "launch",
			name = "Launch file",

			-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

			program = "${file}", -- This configuration will launch the current file if used.
			pythonPath = function()
				-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
				-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
				-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
				local cwd = vim.fn.getcwd()
				if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
					return cwd .. "/venv/bin/python"
				elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
					return cwd .. "/.venv/bin/python"
				else
					return "/usr/bin/python"
				end
			end,
		},
	},
}

-- Dap UI

ui.setup()

vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
end


vim.keymap.set("n", "<leader>dt", function()
    require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint", noremap = true, nowait = true })

vim.keymap.set("n", "<leader>dc", function()
    require("dap").continue()
end, { desc = "Continue", noremap = true, nowait = true })

vim.keymap.set("n", "<leader>di", function()
    require("dap").step_into()
end, { desc = "Step Into", noremap = true, nowait = true })

vim.keymap.set("n", "<leader>do", function()
    require("dap").step_over()
end, { desc = "Step Over", noremap = true, nowait = true })

vim.keymap.set("n", "<leader>du", function()
    require("dap").step_out()
end, { desc = "Step Out", noremap = true, nowait = true })

vim.keymap.set("n", "<leader>dr", function()
    require("dap").repl.open()
end, { desc = "Open REPL", noremap = true, nowait = true })

vim.keymap.set("n", "<leader>dl", function()
    require("dap").run_last()
end, { desc = "Run Last", noremap = true, nowait = true })

vim.keymap.set("n", "<leader>dq", function()
    require("dap").terminate()
    require("dapui").close()
    require("nvim-dap-virtual-text").toggle()
end, { desc = "Terminate", noremap = true, nowait = true })

vim.keymap.set("n", "<leader>db", function()
    require("dap").list_breakpoints()
end, { desc = "List Breakpoints", noremap = true, nowait = true })

vim.keymap.set("n", "<leader>de", function()
    require("dap").set_exception_breakpoints({ "all" })
end, { desc = "Set Exception Breakpoints", noremap = true, nowait = true })
