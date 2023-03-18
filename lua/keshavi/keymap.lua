local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options) end
  vim.keymap.set(mode, lhs, rhs, options)
end



map("", "<Space>", "<Nop>")
map('v', "<C-c>", "<Nop>")
vim.g.mapleader = " "


--insert
map("i", "kj", "<Esc>")

--enter visual block remap because <C-v> is past in my terminal
map("n", "<A-v>", "<C-v>")

--keep centered
map("n", "J", "mzJ`z")
--redo last '/' or '?'
map("n", "<n>", "nzzzv")
map("n", "<N>", "Nzzzv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

--yank in different register

map("n", "<A-Y>", [["+Y]])
map({ "n", "v" }, "<A-d>", [["_d]])


-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

map("n", "<A-j>", ":m .+1<CR>==gi<ESC>")
map("n", "<A-k>", ":m .-2<CR>==gi<ESC>")

--Visual
map("v", "p", [["_dP]])
--paste without yanking
--move lines
map("v", "<A-j>", ":m '>+1<CR>gv-gv")
map("v", "<A-k>", ":m '<-2<CR>gv-gv")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")


local wk = require('which-key')
local builtin = require('telescope.builtin')


map("n", "<leader>u", "<cmd>UndotreeToggle<cr>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

map("n", "<leader>tl", "<cmd>lua _LAZYGIT_TOGGLE()<cr>")
map("n", "<leader>th", "<cmd>lua _HTOP_TOGGLE()<cr>")
map("n", "<leader>tn", "<cmd>lua _NCDU_TOGGLE()<cr>")
wk.register({["<leader>t"] = {name = "Terminals"}})

wk.register({
  s = { '<cmd>so<cr>', "Source file" },
  w = { '<cmd>w<cr>', "Save file" },
  q = { '<cmd>wa<cr><cmd>q<cr>', "Quit" },
  f = {
    name = "Telescope",
    f = { builtin.find_files, "Find Files" },
    g = { builtin.git_files, "Find Git Files" },
    s = { function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, "Search Files" },
    h = { builtin.help_tags, "Help Tags" },
  }, -- f end
}, { prefix = "<leader>" })

wk.register({
  name = "Fix",
  n = { "<cmd>cnext<cr>", "Q-Fix Next" },
  p = { "<cmd>pnext<cr>", "Q-Fix Previous" },
  o = { "<cmd>copen<cr>", "Q-Fix Open" },
  f = { vim.lsp.buf.format, "Format" }
}, { prefix = "<C-f>" })
