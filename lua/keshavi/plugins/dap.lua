require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})




local dap, dapui = require("dap"), require("dapui")

local codelldb_path = vim.env.HOME .. '.local/share/nvim/mason/bin/codelldb'
local liblldb_path = 'usr/lib/liblldb.so'
dap.adapters.codelldb = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)

dap.configurations.rust = {
  {
    type = 'rust',
    request = 'launch',
    name = "Launch rust file",
  },
}

vim.fn.sign_define('DapBreakpoint',{ text ='🛑', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})
require("which-key").register({
  ['<A-5>'] = { function() dap.continue() end, "debug continue" },
  ['<A-7>'] = { function() dap.step_back() end, "step_back" },
  ['<A-8>'] = { function() dap.step_over() end, "step_over" },
  ['<A-9>'] = { function() dap.step_into() end, "step_into" },
  ['<A-0>'] = { function() dap.step_out() end, "step_out" },
  ['<leader>dc'] = { function() dap.run_to_cursor() end, "run_to_cursor" },
  ['<Leader>db'] = { function() dap.toggle_breakpoint() end, "toggle_breakpoint" },
  ['<Leader>dr'] = { function() dap.repl.toggle() end, "toggle repl" },
  ['<Leader>dl'] = { function() dap.run_last() end, "run_last" },
  ['<leader>d'] = {name = 'Debug'}
})


dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
