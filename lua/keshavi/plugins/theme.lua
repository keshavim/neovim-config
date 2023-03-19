require("onedarkpro").setup()

-- luacheck: globals vim
function Enable_Theme(color)
	local color = color or "onedark"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", {bg = "none", ctermbg="none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none", ctermbg="none"})

end

Enable_Theme()


