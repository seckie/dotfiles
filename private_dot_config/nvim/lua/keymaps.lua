local keymap = vim.keymap

-- リーダーキーをスペースに設定
-- vim.g.mapleader = " "

-- ノーマルモードでは ";" を ":" に
keymap.set("n", ";", ":")

-- メモファイルを開く
keymap.set("n", "<Space>m", ":edit ~/Dropbox/memo.txt<CR>")
-- init.luaを開く
keymap.set("n", "<Space>i", ":edit ~/.local/share/chezmoi/private_dot_config/nvim/init.lua<CR>")
-- chezmoi applyする
keymap.set("n", "<Space>ca", ":!chezmoi apply<CR>")

