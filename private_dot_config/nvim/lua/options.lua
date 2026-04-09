local opt = vim.opt

opt.number = true         -- 行番号を表示
opt.relativenumber = true -- 相対行番号を表示
opt.tabstop = 4           -- タブ幅
opt.shiftwidth = 4        -- インデント幅
opt.expandtab = true      -- タブをスペースに変換　
opt.smartindent = true    -- 賢いインデント
opt.termguicolors = true  -- 24bitカラーを有効化
opt.clipboard = 'unnamedplus' -- yankをシステムクリップボードに連携
opt.cursorline = true     -- カーソル業をハイライト
opt.autochdir = true      -- ファイルのディレクトリに自動で移動

