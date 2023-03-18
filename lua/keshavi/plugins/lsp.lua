local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'clangd'
})

-- Fix Undefined global 'vim'
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end
local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<CR>"] = cmp.mapping.confirm({ select = true }),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif check_backspace() then
      fallback()
    else
      fallback()
    end
  end, {
    "i",
    "s",
  }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, {
    "i",
    "s",
  }),
  ["<C-j>"] = cmp.mapping(function()
    cmp.scroll_docs(2)
  end),
  ["<C-k>"] = cmp.mapping(function()
    cmp.scroll_docs(-2)
  end),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

local cmp_format = function(entry, vim_item)
  -- Kind icons
  vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
  -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
  vim_item.menu = ({
    nvim_lsp = "[LSP]",
    luasnip = "[Snippet]",
    buffer = "[Buffer]",
    path = "[Path]",
  })[entry.source.name]
  return vim_item
end
lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  formating = {
    format = cmp_format
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lsp_signature_help" }
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  }
})


lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    hint = "",
    info = "",
    warning = "",
    error = "",
  }
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  local buf = vim.lsp.buf

  vim.keymap.set("n", "gd", function() buf.definition() end, opts)
  vim.keymap.set("n", "gD", function() buf.declaration() end, opts)
  vim.keymap.set("n", "gI", function() buf.implementation() end, opts)
  vim.keymap.set("n", "gr", function() buf.references() end, opts)
  vim.keymap.set("n", "K", function() buf.hover() end, opts)
  vim.keymap.set("n", "<leader>lw", function() buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>la", function() buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>lr", function() buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() buf.signature_help() end, opts)

  vim.keymap.set("n", "<leader>lf", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

  vim.keymap.set("n", "<leader>rr", ":RustRunnables<cr>", opts)
  vim.keymap.set("n", "<leader>rd", ":RustDebuggables<cr>", opts)
  vim.keymap.set("n", "<leader>rc", ":RustOpenCargo<cr>", opts)
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

--so rust doesn't break
local rust_lsp = lsp.build_options('rust_analyzer', {})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true, --very inconvenient but still kind of useful
  severity_sort = true,
})


local rt = require('rust-tools')
rt.setup({
  server = rust_lsp,
})
