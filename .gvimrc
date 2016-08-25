version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim

let &cpo=s:cpo_save
unlet s:cpo_save

if has('win32')
  set columns=178
  set lines=54
elseif has('gui_macvim')
  set columns=237
  set lines=66
endif
set guioptions-=T

"---------------------------------------------------------------------------
" フォント設定:
"
if has('win32')
  set guifont=VL_Gothic:h10:cSHIFTJIS
  "set guifont=MS_Gothic:h12:cSHIFTJIS
  "set guifont=MS_Mincho:h12:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('gui_macvim')
"  set guifont=Osaka-Mono:h16
"  set guifontwide=Osaka-Mono:h16
  set guifont=VL_Gothic:h15
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
"  set guifontset=a14,r14,k14
endif

"---------------------------------------------------------------------------
" Window Positioning
"
nnoremap <Space>1m :<C-u>winpos 0 0<CR>
nnoremap <Space>2m :<C-u>winpos -1276 0<CR>

" Vim-users.jp - Hack #120: gVim でウィンドウの位置とサイズを記憶する
" http://vim-jp.org/vim-users-jp/2010/01/28/Hack-120.html
" note: 実行順序に注意。transparencyより後に実行しないとウィンドウ位置が再現できない
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
  au!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif

" Coloring----------------------------------------------------------------------
  "colorscheme
"colorscheme jellybeanscustom
"colorscheme less
colorscheme molokai

" overwrite "less" colorscheme
highlight Directory guifg=LightBlue

highlight Pmenu guibg=#666666
highlight PmenuSel guibg=#0033BB guifg=#ffffff
highlight PmenuSbar guibg=#333333
highlight Cursorline guibg=#292929 guisp=#555555
"highlight NonText guifg=#333333
highlight SpecialKey guifg=#292929

" vim: set ft=vim :

if has('win32')
"    gui
"    set transparency=246
elseif has('gui_macvim')
  gui
  set transparency=2
endif
