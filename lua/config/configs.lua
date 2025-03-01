--options
local options = {
  backup = false, -- creates a backup file
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = false, -- highlight all matches on previous search pattern
  incsearch = true,
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  showtabline = 2, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeout = true, -- enable timeout
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 100, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  numberwidth = 2, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 8, -- minimal number of screen columns either side of cursor if wrap is `false`
  guifont = "Consolas", -- the font used in graphical neovim applications
  whichwrap = "bs<>[]hl", -- which "horizontal" keys are allowed to travel to prev/next line
  showmode = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.list = false
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("space:⋅")

vim.opt.iskeyword:append("-") -- hyphenated words recognized by searches
vim.opt.shortmess:append("c")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--callbacks
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})
