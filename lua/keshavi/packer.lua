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
-- nvim-telescope/telescope-project.nvim
-- jose-elias-alvarez/null-ls.nvim
-- ahmedkhalf/project.nvim
-- akinsho/bufferline.nvim
-- Saecki/crates.nvim
-- krady21/compiler-explorer.nvim
-- petertriho/nvim-scrollbar
--]]
return packer.startup(function(use)
  use { "wbthomason/packer.nvim" }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use({
    'mrjones2014/legendary.nvim',
    -- don't really require, but it helps
    requires = {
      'kkharji/sqlite.lua',
      'stevearc/dressing.nvim'
    }
  })
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use { "HiPhish/nvim-ts-rainbow2" }
  use { "olimorris/onedarkpro.nvim" }
  use { "folke/tokyonight.nvim" }
  use { "ThePrimeagen/harpoon" }
  use { "mbbill/undotree" }
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      { 'jose-elias-alvarez/null-ls.nvim' },
      { "folke/trouble.nvim" },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },                    -- Required
      { 'hrsh7th/cmp-nvim-lsp' },                -- Required
      { 'hrsh7th/cmp-buffer' },                  -- Optional
      { 'hrsh7th/cmp-path' },                    -- Optional
      { 'saadparwaiz1/cmp_luasnip' },            -- Optional
      { 'hrsh7th/cmp-nvim-lua' },                -- Optional
      { 'hrsh7th/cmp-nvim-lsp-signature-help' }, --optional
      { "hrsh7th/cmp-cmdline" },                 --optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  }
  use { "folke/todo-comments.nvim" }
  use { 'rmagatti/goto-preview' }
  use { "SmiteshP/nvim-navic" }
  use { 'simrat39/rust-tools.nvim' }
  use { "folke/neodev.nvim" }
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use { 'numToStr/Comment.nvim' }
  use { 'lewis6991/gitsigns.nvim' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'nvim-tree/nvim-web-devicons' }
  use { 'akinsho/toggleterm.nvim', tag = '*' }
  use { "windwp/nvim-autopairs" }
  use { "folke/which-key.nvim" }
  use { 'norcalli/nvim-colorizer.lua' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'RRethy/vim-illuminate' }
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
  use { 'goolord/alpha-nvim' }
  use { 'tpope/vim-repeat' }
  use { 'phaazon/hop.nvim', branch = 'v2' }
  use { 'folke/zen-mode.nvim' }
  use { "lukas-reineke/indent-blankline.nvim" }





  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
