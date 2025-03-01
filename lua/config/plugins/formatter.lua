return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
    },
    formatters = {
      stylua = {
        args = { "--indent-type", "Spaces", "--indent-width", "2", "-" },
      },
      isort = {
        args = { "--profile", "black" },
      },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    },
  },
}
