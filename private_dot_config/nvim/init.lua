-- Set leader key to space
vim.g.mapleader = ' '

-- Basic settings
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.tabstop = 4            -- Number of spaces tabs count for
vim.opt.shiftwidth = 4         -- Size of an indent
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.smartindent = true     -- Insert indents automatically
vim.opt.hlsearch = true        -- Highlight all matches on previous search pattern
vim.opt.incsearch = true       -- Highlight matches as you type
vim.opt.ignorecase = true      -- Ignore case in search patterns
vim.opt.smartcase = true       -- Override ignorecase if search pattern contains uppercase

-- Key mappings
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })  -- Save file
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })  -- Quit
vim.keymap.set('n', '<leader>x', ':x<CR>', { noremap = true, silent = true })  -- Save and quit

-- Plugin manager setup (using packer.nvim)
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'  -- Packer can manage itself

  -- Add your plugins here
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Configure Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {"lua","python","cpp","javascript","rust"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
