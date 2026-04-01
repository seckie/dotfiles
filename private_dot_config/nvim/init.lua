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
  -- My plugins here
  -- 'foo1/bar1.nvim';
  -- 'foo2/bar2.nvim';
  'folke/tokyonight.nvim',
  'rebelot/kanagawa.nvim',
}


-- 
-- Basic options
-- 

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

--
-- Keymaps
--

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

--
-- Color schema
--

vim.cmd("colorscheme kanagawa")

