require("dap").adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode", -- adjust as needed
  name = "lldb",
}

local lldb = {
  name = "Launch lldb",
  type = "lldb",     -- matches the adapter
  request = "launch", -- could also attach to a currently running process
  program = function()
    return vim.fn.input(
      "Path to executable: ",
      vim.fn.getcwd() .. "/",
      "file"
    )
  end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  args = {},
  runInTerminal = false,
}

require("which-key").register({
  ['<A-5>'] = { function() require('dap').continue() end, "debug continue" },
  ['<A-7>'] = { function() require('dap').step_back() end, "step_back" },
  ['<A-8>'] = { function() require('dap').step_over() end, "step_over" },
  ['<A-9>'] = { function() require('dap').step_into() end, "step_into" },
  ['<A-0>'] = { function() require('dap').step_out() end, "step_out" },
  ['<leader>dc'] = { function() require('dap').run_to_cursor() end, "run_to_cursor" },
  ['<Leader>db'] = { function() require('dap').toggle_breakpoint() end, "toggle_breakpoint" },
  ['<Leader>dr'] = { function() require('dap').repl.toggle() end, "toggle repl" },
  ['<Leader>dl'] = { function() require('dap').run_last() end, "run_last" },
})
