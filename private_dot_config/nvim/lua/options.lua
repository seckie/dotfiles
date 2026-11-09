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
    local function switch_ime()
        local output = vim.fn.system({
            'osascript', '-e',
            'tell application "System Events" to key code 49 using control down',
        })
        if vim.v.shell_error ~= 0 then
            vim.notify('IME switch failed: ' .. output, vim.log.levels.ERROR)
        end
    end

    vim.api.nvim_create_autocmd('InsertLeave', {
        callback = switch_ime,
    })

    -- CTRL-C は InsertLeave を発生させないため、キー処理にも切替を追加
    vim.keymap.set('i', '<C-c>', function()
        switch_ime()
        return '<C-c>'
    end, { expr = true, desc = 'Switch IME and leave insert mode' })
end

