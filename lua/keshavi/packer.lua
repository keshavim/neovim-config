--asutomatic sinstall
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  print("Installing packer close and reopen Neovim...")
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

--coment

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)
  use { "wbthomason/packer.nvim" }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use { "olimorris/onedarkpro.nvim" }
  use { "ThePrimeagen/harpoon" }
  use { "mbbill/undotree" }
  use { "tpope/vim-fugitive" }
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },        -- Required
      { 'williamboman/mason.nvim' },      -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },    -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-buffer' },  -- Optional
      { 'hrsh7th/cmp-path' },    -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' }, -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' },        -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  }
  use { 'numToStr/Comment.nvim' }
  use { 'lewis6991/gitsigns.nvim' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'nvim-tree/nvim-web-devicons' }
  use { 'akinsho/toggleterm.nvim', tag = '*' }
  use {"windwp/nvim-autopairs"}
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
