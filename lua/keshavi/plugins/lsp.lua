local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'clangd'
})

lsp.set_preferences({
  manage_nvim_cmp = false, --doing cmp separately because i can't use zero properly
  suggest_lsp_servers = false,
  sign_icons = {
    hint = "",
    info = "",
    warning = "",
    error = "",
  }
})

--the winbar
local navic = require('nvim-navic')
navic.setup {
  icons = {
    File          = " ",
    Module        = " ",
    Namespace     = " ",
    Package       = " ",
    Class         = " ",
    Method        = " ",
    Property      = " ",
    Field         = " ",
    Constructor   = " ",
    Enum          = "練",
    Interface     = "練",
    Function      = " ",
    Variable      = " ",
    Constant      = " ",
    String        = " ",
    Number        = " ",
    Boolean       = "◩ ",
    Array         = " ",
    Object        = " ",
    Key           = " ",
    Null          = "ﳠ ",
    EnumMember    = " ",
    Struct        = " ",
    Event         = " ",
    Operator      = " ",
    TypeParameter = " ",
  },
  highlight = true,
  separator = " > ",
  depth_limit = 6,
  depth_limit_indicator = "..",
  safe_output = true
}
lsp.on_attach(function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  local opts = { buffer = bufnr, remap = false }

  local buf = vim.lsp.buf
  local map = require('keshavi.utils').map

  map("n", "gd", buf.definition, opts)
  map("n", "gD", buf.declaration, opts)
  map("n", "gI", buf.implementation, opts)
  map("n", "gr", buf.references, opts)
  map("n", "K", buf.hover, opts)
  map("n", "<leader>lw", buf.workspace_symbol, opts)
  map("n", "<leader>la", buf.code_action, opts)
  map("n", "<leader>lr", buf.rename, opts)
  map("i", "<C-h>", buf.signature_help, opts)

  map("n", "<leader>lf", vim.diagnostic.open_float, opts)
  map("n", "]d", vim.diagnostic.goto_next, opts)
  map("n", "[d", vim.diagnostic.goto_prev, opts)

  map("n", "<leader>rr", ":RustRunnables<cr>", opts)
  map("n", "<leader>rd", ":RustDebuggables<cr>", opts)
  map("n", "<leader>rc", ":RustOpenCargo<cr>", opts)
  require("which-key").register({
    ["g"] = { name = "diagnostic jump" },
    ["gd"] = "goto definition",
    ["gD"] = "goto declaration",
    ["gI"] = "goto implementation",
    ["gr"] = "goto references",
    ["K"] = "Hover",
    ["<leader>lw"] = "workspace_symbol",
    ["<leader>lf"] = "open_float",
    ["[d"] = "next diagnostic",
    ["]d"] = "previous diagnostic",
    ["<leader>la"] = "code_action",
    ["<leader>lr"] = "rename",
    ["<C-h>"] = "signature help",
    ["<leader>l"] = "Lsp"
  })
  --shows the diagnostic when cursor is over the word
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
end)


--so rust doesn't break
local rust_lsp = lsp.build_options('rust_analyzer', {})

lsp.setup()

vim.diagnostic.config({
  virtual_text = false, --very inconvenient but still kind of useful
  severity_sort = true,
})


local rt = require('rust-tools')
rt.setup({
  server = rust_lsp,
})

require("trouble").setup()

require("goto-preview").setup {
  default_mappings = true
}

--format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
