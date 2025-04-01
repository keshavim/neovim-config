return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "folke/neodev.nvim", opts = {} },
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

      local _border = "rounded"

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
    end,
  },
  {

    "p00f/clangd_extensions.nvim",
    ft = "c/cpp",
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    config = function()
      local rustacean = require("rustaceanvim")
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = {
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
            auto_focus = true,
          },
        },
      }
    end,
  },
  {
    {
      "rust-lang/rust.vim",
      ft = "rust",
      init = function()
        vim.g.rustfmt_autosave = 1
      end,
    },
  },
  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
    end,
  },
}
