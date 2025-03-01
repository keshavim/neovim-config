--keybindings

function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map("i", "kj", "<Esc>:w<CR>", { desc = "escape insert and save" })

map("i", "<Tab>", function()
  local col = vim.fn.col(".") - 1
  local char = vim.fn.getline("."):sub(col + 1, col + 1)
  if char:match("[)%]}\"'>]") then
    return "<Right>"
  else
    return "<Tab>"
  end
end, { expr = true })

map("n", "<leader><leader>e", ":e $MYVIMRC<CR>:Neotree<CR>", { desc = "open config directory" })
map("n", "<Leader><leader>s", ":so %<CR>", { desc = "source current files" })
map("n", "<leader><leader>f", ":Neotree<CR>", { desc = "open file explorer" })
map("n", "<leader><leader>w", ":w<CR>", { desc = "savefile" })
map("n", "<leader><leader>q", function()
  local cant_modify = vim.bo.readonly or not vim.bo.modifiable
  if cant_modify then
    vim.cmd.q()
  else
    vim.cmd([[:wqa<CR>]])
  end
end, { desc = "quit and save" })

map("n", "<A-Y>", [["+Y]], { desc = "special yank" })
map({ "n", "v" }, "<A-d>", [["_d]], { desc = "delete no yank" })
map("v", "p", [["_dP]], { desc = "paste no yank" })

-- Navigate buffers
map("n", "<S-h>", ":bprevious<CR>", { desc = "previous buffer" })
map("n", "<S-l>", ":bnext<CR>", { desc = "next buffer" })
map("n", "<A-j>", "<esc>:m .+1<CR>==", { desc = "move line down" })
map("n", "<A-k>", "<esc>:m .-2<CR>==", { desc = "move line up" })

map("n", "<C-j>", "<C-w>j", { desc = "move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "move to top window" })
map("n", "<C-h>", "<C-w>h", { desc = "move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "move to right window" })

map("n", "<leader>vw", "<C-w>v", { desc = "split window vertically" })
map("n", "<leader>sw", "<C-w>s", { desc = "split window horozontily" })

map("n", "<C-Up>", "<C-w>+", { desc = "Increase window height" })
map("n", "<C-Down>", "<C-w>-", { desc = "Decrease window height" })
map("n", "<C-Right>", "<C-w>>", { desc = "Increase window width" })
map("n", "<C-Left>", "<C-w><", { desc = "Decrease window width" })

map("n", "<S-Tab>", "<<", { desc = "tab shift left" })
map("n", "<tab>", ">>", { desc = "tab shift right" })

--Visual
--paste without yanking
map("v", "p", [["_dP]], { desc = "paste no yank" })
--move lines
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move line down" })

-- Stay in indent mode
map("v", "<S-tab>", "<gv", { desc = "tab shift left" })
map("v", "<tab>", ">gv", { desc = "tab shift right" })

-- Telescope
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Fuzzy find files in cwd" })
map("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", { desc = "Find string in cwd" })
map("n", "<leader>fb", "<CMD>Telescope buffers<CR>", { desc = "Fuzzy find opened files" })
map("n", "<leader>ft", "<CMD>Telescope lsp_type_definitions<CR>", { desc = "Find type definitions" })
map("n", "<leader>fd", "<CMD>Telescope lsp_definitions<CR>", { desc = "Find definitions" })
map("n", "<leaderfi", "<CMD>Telescope lsp_implementations<CR>", { desc = "Find implementations" })
map("n", "<leaderfs", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Find document_symbols" })
map("n", "<leaderfS", "<CMD>Telescope lsp_workplace_symbols<CR>", { desc = "Find workplace_symbols" })
map("n", "<leaderfr", "<CMD>Telescope lsp_references<CR>", { desc = "Find references" })
