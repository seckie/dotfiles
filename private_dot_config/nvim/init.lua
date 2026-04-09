--
-- Plugin management
--

local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
  -- Themes
  'folke/tokyonight.nvim',
  'rebelot/kanagawa.nvim',

  -- Syntax highlighting
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', start = true,
    config = function()
      require('nvim-treesitter.config').setup{
        ensure_installed = { 'python', 'lua' },
        highlight = { enable = true },
      }
    end
  },
}


-- 
-- Basic options
-- 
require('options')


--
-- Keymaps
--
require('keymaps')

--
-- Color schema
--

vim.cmd("colorscheme kanagawa")

