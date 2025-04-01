return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      direction = "float",
      float_opts = { width = math.floor(vim.o.columns * 0.9), height = math.floor(vim.o.lines * 0.9) },
      open_mapping = [[<C-\>]],
    },
  },
}
