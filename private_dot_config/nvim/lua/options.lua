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

-- macOS: normal mode に戻ったら ASCII 入力ソースを選択する
if vim.fn.has('mac') == 1 then
    local function disable_ime()
        local output = vim.fn.system({
            'swift', '-e',
            'import Carbon; TISSelectInputSource(TISCopyCurrentASCIICapableKeyboardInputSource().takeRetainedValue())',
        })
        if vim.v.shell_error ~= 0 then
            vim.notify('Failed to select ASCII input source: ' .. output, vim.log.levels.ERROR)
        end
    end

    vim.api.nvim_create_autocmd('InsertLeave', {
        callback = disable_ime,
    })

    -- CTRL-C は InsertLeave を発生させないため、キー処理にも切替を追加
    vim.keymap.set('i', '<C-c>', function()
        disable_ime()
        return '<C-c>'
    end, { expr = true, desc = 'Disable IME and leave insert mode' })
end

