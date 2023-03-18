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


--[[ possible future plugins, too lazy to configer them right now
-- onsails/lspkind-nvim
-- nvim-telescope/telescope-project.nvim
-- BurntSushi/ripgrep
-- nvim-telescope/telescope-bibtex.nvim
-- HiPhish/nvim-ts-rainbow2
-- folke/zen-mode.nvim
-- folke/tokyonight.nvim
-- jose-elias-alvarez/null-ls.nvim
-- tamago324/lir.nvim
-- ahmedkhalf/project.nvim
-- akinsho/bufferline.nvim
-- SmiteshP/nvim-navic
-- rcarriga/nvim-dap-ui
-- Saecki/crates.nvim
-- RRethy/vim-illuminate
-- lukas-reineke/indent-blankline.nvim
-- goolord/alpha-nvim
-- sunjon/Shade.nvim
-- xiyaowong/nvim-transparent
-- krady21/compiler-explorer.nvim
-- stevearc/dressing.nvim 
-- kevinhwang91/nvim-ufo
-- zbirenbaum/neodim
-- ggandor/leap.nvim
-- mrjones2014/legendary.nvim
-- petertriho/nvim-scrollbar
--]]

return packer.startup(function(use)
  use { "wbthomason/packer.nvim" }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use { "olimorris/onedarkpro.nvim" }
  use { "ThePrimeagen/harpoon" }
  use { "mbbill/undotree" }
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
      {'hrsh7th/cmp-nvim-lsp-signature-help'},

      -- Snippets
      { 'L3MON4D3/LuaSnip' },        -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  }
  use {'simrat39/rust-tools.nvim'}
  use {'mfussenegger/nvim-dap'}
  use { 'numToStr/Comment.nvim' }
  use { 'lewis6991/gitsigns.nvim' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'nvim-tree/nvim-web-devicons' }
  use { 'akinsho/toggleterm.nvim', tag = '*' }
  use {"windwp/nvim-autopairs"}
  use {"folke/which-key.nvim"}
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
