local map = require('keshavi.utils').map



map("", "<Space>", "<Nop>")
map('v', "<C-c>", "<Nop>")
vim.g.mapleader = " "


map("i", "kj", "<Esc>")
map("i", "<S-tab>", "<c-d>")
-- map("i", "<Tab>", function() return "<tab>" end)


--enter visual block remap because <C-v> is paste in my terminal
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
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

map("n", "<S-h>", ":bprevious<CR>")
map("n", "<S-l>", ":bnext<CR>")
-- Navigate buffers
map("n", "<A-j>", "<esc>:m .+1<CR>==")
map("n", "<A-k>", "<esc>:m .-2<CR>==")

map("n", "<S-Tab>", "<<")
map("n", "<tab>", ">>")

--Visual
--paste without yanking
map("v", "p", [["_dP]])
--move lines
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")


local wk = require('which-key')
local builtin = require('telescope.builtin')

--hop
require('hop').setup {}
map("n", "<leader><leader>h", "<cmd>HopWord<cr>")
map("n", "<leader><leader>c", "<cmd>HopChar2<cr>")
map("n", "<leader><leader>l", "<cmd>HopLineStart<cr>")
map("n", "<leader><leader>p", "<cmd>HopPattern<cr>")

--comand palete
map("n", "<leader>p", "<cmd>Legendary<cr>")
wk.register({ ["<leader>p"] = "Command Palete" })

--tree toggle
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

--terminal
map("n", "<leader>tl", "<cmd>lua _LAZYGIT_TOGGLE()<cr>")
map("n", "<leader>th", "<cmd>lua _HTOP_TOGGLE()<cr>")
map("n", "<leader>tn", "<cmd>lua _NCDU_TOGGLE()<cr>")
wk.register({ ["<leader>t"] = { name = "Terminals" } })

map('n', "<leader>z", "<cmd>ZenMode<cr>")

--trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
map("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>")


wk.register({
  s = { '<cmd>so<cr>', "Source file" },
  w = { '<cmd>w<cr>', "Save file" },
  q = { '<cmd>q<cr>', "Quit" },
  ["<leader>w"] = { "<cmd>wa<cr>", "Save All" },
  ['<leader>q'] = { "<cmd>wa<cr><cmd>q<cr>", "Save all and Quit" },
  f = {
    name = "Telescope",
    f = { builtin.find_files, "Find Files" },
    o = { builtin.old_files, "Opened Files" },
    g = { builtin.git_files, "Find Git Files" },
    h = { builtin.help_tags, "Help Tags" },
    k = { builtin.keymaps, "KeyMap List" },
    m = { builtin.man_pages, "Man Pages List" },
    d = { builtin.diagnostics, "Diagnostics List" },
    s = { function()
      builtin.grep_string({ search = vim.fn.input("Grep > "), grep_open_files = true })
    end, "Search Files" },
    S = { builtin.live_grep, "Search Directory Live" },
    c = { function()
      builtin.colorscheme({ enable_preview = true })
    end, "colorschemes List" }
  }, -- f end
}, { prefix = "<leader>" })

wk.register({
  name = "Fix",
  n = { "<cmd>cnext<cr>", "Q-Fix Next" },
  p = { "<cmd>pnext<cr>", "Q-Fix Previous" },
  o = { "<cmd>copen<cr>", "Q-Fix Open" },
  f = { vim.lsp.buf.format, "Format" }
}, { prefix = "<C-f>" })
