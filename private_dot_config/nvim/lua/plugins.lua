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

  -- Git integration (signcolumn markers + inline blame)
  { 'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup{
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 500,
        },
        current_line_blame_formatter = '<abbrev_sha> · <author>, <author_time:%Y-%m-%d> · <summary>',
        on_attach = function(bufnr)
          local gs = require('gitsigns')
          local function map(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, expr = true })
          end

          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end)
          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end)
        end,
      }
    end
  },

  -- Open/copy GitHub URLs for current line or blame commit
  { 'linrongbin16/gitlinker.nvim',
    config = function()
      require('gitlinker').setup()
      local map = vim.keymap.set
      local function opts(desc) return { silent = true, noremap = true, desc = desc } end
      map({'n','v'}, '<leader>gl', '<cmd>GitLink<cr>',        opts('Copy GitHub URL for current line'))
      map({'n','v'}, '<leader>gL', '<cmd>GitLink!<cr>',       opts('Open current line on GitHub'))
      map({'n','v'}, '<leader>gb', '<cmd>GitLink blame<cr>',  opts('Copy GitHub URL for blame commit'))
      map({'n','v'}, '<leader>gB', '<cmd>GitLink! blame<cr>', opts('Open blame commit on GitHub'))
    end
  },
}

