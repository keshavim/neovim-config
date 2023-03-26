local cmp = require("cmp")
local luasnip = require("luasnip")
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = '#da2200' })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = '#007289' })

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
  return col == 0 or vim.fn.getline(vim.fn.line(".")):sub(col, col):match "%s"
end
local check_ending = function()
  local col = vim.fn.col(".")
  local line = vim.fn.getline(vim.fn.line('.')):sub(col, col)
  local chars = ")]}'\">`"
  print(line)
  return string.find(chars, line) ~= nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
        -- elseif check_ending() then
        -- require("keshavi.utils").map("i", "<tab>", "<C-o>a")
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
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = vim_item.kind
      -- Kind icons
      vim_item.kind = kind_icons[kind]
      vim_item.menu = kind .. " " .. ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      vim_item.abbr = vim_item.abbr:match("[^(]+")
      return vim_item
    end,
  },
  sources = {
    {
      name = "nvim_lsp",
      entry_filter = function(entry, ctx)
        if entry:get_kind() == 15 then
          return false
        end
        return true
      end
    },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim-lsp-signature-help" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered({
      border = "none",
      col_offset = -2
    }),
    documentation = cmp.config.window.bordered()
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
