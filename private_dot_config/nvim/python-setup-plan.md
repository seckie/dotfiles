# NeoVim Python開発環境 フルセットアッププラン

## 追加プラグイン一覧 (7つ)

| プラグイン | 役割 |
|---|---|
| `nvim-treesitter/nvim-treesitter` | 高精度シンタックスハイライト |
| `neovim/nvim-lspconfig` | LSPクライアント設定 |
| `williamboman/mason.nvim` | LSPサーバー等のインストーラ |
| `williamboman/mason-lspconfig.nvim` | mason↔lspconfig連携 |
| `hrsh7th/nvim-cmp` | 補完エンジン |
| `hrsh7th/cmp-nvim-lsp` | LSP補完ソース |
| `L3MON4D3/LuaSnip` | スニペットエンジン (cmp依存) |

## ツール選定理由

- **pyright** (LSP): Microsoft製、設定不要で型チェック・補完・定義ジャンプが動く
- **ruff** (リンター+フォーマッター): Black + flake8 を1ツールで代替。高速。mason経由でインストールするのでpip不要
- **mason.nvim**: pyright/ruffのバイナリ管理を自動化

## pckr.addブロック

```lua
require('pckr').add{
  -- Themes
  'folke/tokyonight.nvim',
  'rebelot/kanagawa.nvim',

  -- Syntax highlighting
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup{
        ensure_installed = { 'python', 'lua' },
        highlight = { enable = true },
      }
    end
  },

  -- LSP
  { 'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  { 'williamboman/mason-lspconfig.nvim',
    requires = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup{
        ensure_installed = { 'pyright', 'ruff' },
      }
    end
  },
  'neovim/nvim-lspconfig',

  -- Completion
  'L3MON4D3/LuaSnip',
  'hrsh7th/cmp-nvim-lsp',
  { 'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip' },
    config = function()
      local cmp = require('cmp')
      cmp.setup{
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = 'nvim_lsp' },
        },
      }
    end
  },
}
```

## LSPセットアップセクション (Keymapsの後、Colorschemeの前に追加)

```lua
--
-- LSP Setup
--

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Pyright: 型チェック、定義ジャンプ、ホバードキュメント、補完
require('lspconfig').pyright.setup{
  capabilities = capabilities,
}

-- Ruff: リント・フォーマット
require('lspconfig').ruff.setup{
  capabilities = capabilities,
}

-- 保存時に自動フォーマット (ruff)
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.py',
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- LSPキーマップ (LSPがアタッチされたバッファでのみ有効)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<Space>la', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  end,
})
```

## LSPキーマップ一覧

| キー | モード | 機能 |
|---|---|---|
| `gd` | Normal | 定義へジャンプ |
| `K` | Normal | ホバードキュメント |
| `gr` | Normal | 参照一覧 |
| `<Space>rn` | Normal | リネーム |
| `<Space>la` | Normal | コードアクション |
| `[d` / `]d` | Normal | 前/次の診断 |
| `<Tab>` / `<S-Tab>` | Insert | 補完候補を選択 |
| `<CR>` | Insert | 補完確定 |
| `<C-Space>` | Insert | 手動補完トリガー |

## 注意事項

- 既存の `<Space>ca` (chezmoi apply) を `<Space>za` に変更する（LSP code_actionとの競合回避）
