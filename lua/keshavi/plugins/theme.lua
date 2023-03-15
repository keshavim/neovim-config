require("onedarkpro").setup()

-- luacheck: globals vim
function ColorMyPencils()
	local color = "onedark"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", {bg = "none", ctermbg="none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none", ctermbg="none"})

end

ColorMyPencils()


