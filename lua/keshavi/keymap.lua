

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend("force", options) end
    vim.keymap.set(mode, lhs, rhs, options)
end

map("", "<Space>", "<Nop>")
map('v', "<C-c>", "<Nop>")
vim.g.mapleader = " "


--insert
map("i", "kj", "<Esc>")


--normal
map("n", "<leader>pv", vim.cmd.Ex)

--enter visual block remap because <C-v> is past in my terminal
map("n", "<A-v>","<C-v>") 

--keep centered
map("n", "J", "mzJ`z")
--redo last '/' or '?'
map("n", "<n>", "nzzzv")
map("n", "<N>", "Nzzzv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

--yank in different register

map("n", "<leader>Y", [["+Y]])
map({"n", "v"}, "<leader>d", [["_d]])


map("n", "<leader>f", vim.lsp.buf.format)

--buffer save, quit, and source 
map("n", "<leader><leader>", "<cmd>so<CR>")
map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>q<CR>")

--quicklist
map("n", "<leader>qn", "<cmd>:cnext<cr>")
map("n", "<leader>qp", "<cmd>:cprev<cr>")
map("n", "<leader>qo", "<cmd>:copen<cr>")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")


--Visual
--paste without yanking
map("v", "p", [["_dP]])

--move lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")






















