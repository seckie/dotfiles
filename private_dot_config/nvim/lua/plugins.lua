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
        ensure_installed = { 'python', 'lua', 'typescript', 'tsx' },
        highlight = { enable = true },
      }
    end
  },

  -- LSP
  'neovim/nvim-lspconfig',
  { 'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  { 'williamboman/mason-lspconfig.nvim',
    requires = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      require('mason-lspconfig').setup{
        ensure_installed = { 'pyright', 'lua_ls', 'ts_ls' },
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('*', { capabilities = capabilities })
      vim.lsp.enable({ 'pyright', 'lua_ls', 'ts_ls' })
    end
  },

  -- Completion
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup{
        mapping = cmp.mapping.preset.insert{
          ['<C-b>']     = cmp.mapping.scroll_docs(-4),
          ['<C-f>']     = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>']     = cmp.mapping.abort(),
          ['<CR>']      = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      }
    end
  },
}

