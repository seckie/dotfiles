local opt = vim.opt

opt.number = true         -- 行番号を表示
opt.tabstop = 4           -- タブ幅
opt.shiftwidth = 4        -- インデント幅
opt.expandtab = true      -- タブをスペースに変換　
opt.smartindent = true    -- 賢いインデント
opt.termguicolors = true  -- 24bitカラーを有効化
opt.clipboard = 'unnamedplus' -- yankをシステムクリップボードに連携
opt.cursorline = true     -- カーソル業をハイライト
opt.autochdir = true      -- ファイルのディレクトリに自動で移動

-- macOS: normal mode に戻ったら入力ソース切り替えショートカットを送る
if vim.fn.has('mac') == 1 then
    vim.api.nvim_create_autocmd('InsertLeave', {
        callback = function()
            vim.fn.jobstart({
                'osascript', '-e',
                'tell application "System Events" to key code 49 using control down',
            }, { detach = true })
        end,
    })
end

