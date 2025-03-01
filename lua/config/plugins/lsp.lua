return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", opts = {} },
    "p00f/clangd_extensions.nvim",
  },
  config = function()
    local nvim_lsp = require("lspconfig")

    local protocol = require("vim.lsp.protocol")

    local on_attach = function(client, bufnr)
      -- format on save
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("Format", { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.hover = {
      contentFormat = { "markdown", "plaintext" },
      border = "rounded",
    }

    nvim_lsp.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    nvim_lsp.pylsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = { pycodestyle = { ignore = { "E501" } } },
        },
      },
    })

    nvim_lsp.clangd.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
      },
      filetypes = { "c", "cpp" },
    })

    --customize look of floating window
    local _border = "single"

    vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
      config = config or {}
      config.border = _border
      vim.lsp.handlers.hover(_, result, ctx, config)
    end

    vim.lsp.handlers["textDocument/signatureHelp"] = function(_, result, ctx, config)
      config = config or {}
      config.border = _border
      vim.lsp.handlers.signature_help(_, result, ctx, config)
    end
    vim.diagnostic.config({
      float = { border = _border },
    })
  end,
}
