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

map("i", "kj", function()
  local cant_modify = vim.bo.readonly or not vim.bo.modifiable
  if cant_modify then
    vim.api.nvim_input("<Esc>")
  else
    vim.api.nvim_input("<Esc>")
    vim.cmd("write")
  end
end, { desc = "escape insert and save" })

map("i", "<Tab>", function()
  local col = vim.fn.col(".") - 1
  local char = vim.fn.getline("."):sub(col + 1, col + 1)
  if char:match("[)%]}\"'>]") then
    return "<Right>"
  else
    return "<Tab>"
  end
end, { expr = true })

map("n", "<leader><leader>e", ":e $MYVIMRC<CR>", { desc = "open config directory" })
map("n", "<Leader><leader>s", ":so %<CR>", { desc = "source current files" })
map("n", "<leader>n", ":Neotree<CR>", { desc = "open Neotree file explorer" })
map("n", "<leader>w", ":w<CR>", { desc = "savefile" })
map("n", "<leader><leader>q", function()
  local cant_modify = vim.bo.readonly or not vim.bo.modifiable
  if cant_modify then
    vim.cmd.q()
  else
    vim.cmd([[:wqa<CR>]])
  end
end, { desc = "quit and save" })

map({ "n", "v" }, "<A-d>", [["_d]], { desc = "delete no yank" })
map("v", "p", [["_dP]], { desc = "paste no yank" })
map("n", "<A-Y>", [["+Y]], { desc = "special yank" })

-- Navigate buffers
map("n", "<S-h>", ":bprevious<CR>", { desc = "previous buffer" })
map("n", "<S-l>", ":bnext<CR>", { desc = "next buffer" })
map("n", "<A-j>", "<esc>:m .+1<CR>==", { desc = "move line down" })
map("n", "<A-k>", "<esc>:m .-2<CR>==", { desc = "move line up" })

map("n", "<A-h>", "0", { desc = "move to end of line" })
map("n", "<A-l>", "$", { desc = "move to begining of line" })

map("n", "<C-d>", "<C-d>zz", { desc = "scroll down half page and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "scroll up half page and center" })
map("n", "<C-f>", "<C-f>zz", { desc = "scroll down page and center" })
map("n", "<C-b>", "<C-b>zz", { desc = "scroll up half page and center" })

--
-- map("n", "<C-j>", "<C-w>j", { desc = "move to bottom window" })
-- map("n", "<C-k>", "<C-w>k", { desc = "move to top window" })
-- map("n", "<C-h>", "<C-w>h", { desc = "move to left window" })
-- map("n", "<C-l>", "<C-w>l", { desc = "move to right window" })
--
-- map("n", "<leader>vw", "<C-w>v", { desc = "split window vertically" })
-- map("n", "<leader>sw", "<C-w>s", { desc = "split window horozontily" })
--
-- map("n", "<C-Up>", "<C-w>+", { desc = "Increase window height" })
-- map("n", "<C-Down>", "<C-w>-", { desc = "Decrease window height" })
-- map("n", "<C-Right>", "<C-w>>", { desc = "Increase window width" })
-- map("n", "<C-Left>", "<C-w><", { desc = "Decrease window width" })
--
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
map("n", "<leader>fi", "<CMD>Telescope lsp_implementations<CR>", { desc = "Find implementations" })
map("n", "<leader>fs", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Find document_symbols" })
map("n", "<leader>fS", "<CMD>Telescope lsp_workplace_symbols<CR>", { desc = "Find workplace_symbols" })
map("n", "<leader>fr", "<CMD>Telescope lsp_references<CR>", { desc = "Find references" })

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

--lsp
autocmd("LspAttach", {
  group = augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>F", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "E", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

--terminal

-- Function to delete and recreate the terminal
function _G.delete_and_recreate_terminal()
  local term_id = 1                            -- Replace with your terminal ID if managing multiple
  vim.cmd("ToggleTerm" .. term_id .. " close") -- Close the terminal
  vim.cmd("ToggleTerm" .. term_id)
end

-- Keybinding for deleting and recreating the terminal
map("n", "<leader>rt", ":lua delete_and_recreate_terminal()<CR>", { desc = "deleate and create new terminal instance" })
