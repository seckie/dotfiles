version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim

" runtimepath
"if has('win32')
"  set runtimepath+=D:\My\ Dropbox\vimfiles
"  let $VF = 'D:/My\ Dropbox/vimfiles'
"elseif has('gui_macvim')
"  set runtimepath+=$HOME/Dropbox/vimfiles
"  let $VF = $HOME . '/Dropbox/vimfiles'
"else
"  set runtimepath+=$HOME/Dropbox/vimfiles
"  let $VF = $HOME . '/Dropbox/vimfiles'
"endif

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/dotfiles/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin($HOME . '/dotfiles/.vim/dein')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('git-mirror/vim-l9')
call dein#add('kana/vim-textobj-user')
call dein#add('kana/vim-operator-user')

call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neocomplete')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neoyank.vim')
call dein#add('thinca/vim-template')
call dein#add('thinca/vim-qfreplace')
call dein#add('hrp/EnhancedCommentify')
call dein#add('tpope/vim-surround')
call dein#add('h1mesuke/vim-alignta.git')
call dein#add('mattn/emmet-vim')
call dein#add('thinca/vim-quickrun.git')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('scrooloose/nerdtree')

" PHP Debug
call dein#add('joonty/vdebug.git')

" Syntax
call dein#add('jiangmiao/simple-javascript-indenter')
call dein#add('jelera/vim-javascript-syntax')
call dein#add('kchmck/vim-coffee-script')
call dein#add('tpope/vim-haml')
call dein#add('groenewege/vim-less')
call dein#add('wavded/vim-stylus')
call dein#add('digitaltoad/vim-jade')
call dein#add('leafgarland/typescript-vim')

" You can specify revision/branch/tag.
" call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

" basic setting 1------------------------------------------------------------------
" indent style
set shiftwidth=2
set tabstop=2
set expandtab
set cmdheight=2

" basic setting 2------------------------------------------------------------------
" language & encoding
set fileencodings=guess,utf-8,ucs-bom,ucs-2le,ucs-2,iso-2022-jp-3,euc-jisx0213,euc-jp
set helplang=ja
set formatexpr=Format_Japanese()

" clipboard
set clipboard=unnamed

" format
  " 自動改行させない
set textwidth=0
set autoindent
set backspace=2
set formatoptions=tcqmM
set ruler
set laststatus=2
set wrap
  " for bracket
set showmatch
set printfont=MS_Mincho:h12:cSHIFTJIS
set ignorecase
set smartcase

" visual
syntax enable
set background=dark
colorscheme molokai

  " title bar
set title
set wildmenu
set window=61
set visualbell
set cursorline
set list
set listchars=tab:\|-,extends:$
set magic

" Display filename, encoding, bomb and ff in statusline
if has('iconv')
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':':NOBOM').']['.&ff.']'}%=[0x%{FencB()}]\ (%v,%l)/%L%8P\ 
else
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':':NOBOM').']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 
endif

function! FencB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return s:Byte2hex(s:Str2byte(c))
endfunction
function! s:Str2byte(str)
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction
function! s:Byte2hex(bytes)
  return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction

" other
set history=50

" IME
set iminsert=0
set imsearch=0

" folding
set foldenable
set foldclose=all
set foldlevel=0
set foldmethod=marker

" backup
set nobackup
  " define backup dir
set directory=$HOME/vimbackup
set backupdir=$HOME/vimbackup
set undodir=$HOME/vimbackup

" search
set incsearch
set hlsearch
  " when '/' search
cnoremap <expr> /
\ getcmdtype() == '/' ? '\/' : '/'


" file and directory---------------------------------------------------------------

" shortcut for vim config files
nnoremap <Space>. <Esc>:<C-u>source ~/dotfiles/.vimrc<CR>:<C-u>source ~/dotfiles/.gvimrc<CR>
nnoremap <Space>v :e ~/dotfiles/.vimrc<CR>
nnoremap <Space>g :e ~/dotfiles/.gvimrc<CR>
nnoremap <Space>sh :e ~/.vim/snippets/html.snippets<CR>
nnoremap <Space>sp :e ~/.vim/snippets/php.snippets<CR>
nnoremap <Space>sc :e ~/.vim/snippets/css.snippets<CR>
nnoremap <Space>ss :e ~/.vim/snippets/scss.snippets<CR>
nnoremap <Space>sj :e ~/.vim/snippets/javascript.snippets<CR>

" keymap---------------------------------------------------------------------------
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
" shortcut for help
nnoremap <C-h> :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><Enter>
map <S-Insert> <MiddleMouse>
" force IME off when escape from inster mode
inoremap <silent> <C-c> <C-c>:set iminsert=0<CR>
inoremap <silent> <Esc> <Esc>:set iminsert=0<CR>
" window size
nnoremap + 4<C-w>+
nnoremap - 4<C-w>-
nnoremap { 4<C-w><
nnoremap } 4<C-w>>
" cursor move
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <C-@> `.
nnoremap vv v$h

"encoding
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf8
command! Jis Iso2022jp
command! Sjis Cp932

"date auto Insert
inoremap <expr> ,df strftime('%Y-%m-%dT%H:%M:%S')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')

"select last changed text
nnoremap gc '[V']
vnoremap gc :<C-u>normal gc<Enter>
onoremap gc :<C-u>normal gc<Enter>

"merge lines and delete space
nnoremap <C-J> Jdl

"confrol registers
nnoremap x "_x

" from WebGL shader program to JavaScript string
vnoremap ,s :s/^\(\s\s\)\?\(.*[{};]\\|#ifdef.*\\|#endif.*\)$/  "\2\",/g<Enter>

"dayly use note file
if has('win32')
  nnoremap <Space>m <Esc>:<C-u>e D:/My\ Dropbox/memo.txt<CR>
elseif has('gui_macvim')
  nnoremap <Space>m <Esc>:<C-u>e $HOME/Dropbox/memo.txt<CR>
  nnoremap <Space>p <Esc>:<C-u>e $HOME/Dropbox/Apps/Byword/pm-memo.md<CR>
endif


" for plugins----------------------------------------------------------------------

" --------------------
" for "Simple Javascript Indenter" plugin
" --------------------
let g:SimpleJsIndenter_BriefMode = 1

" --------------------
" for "unite.vim" plugin
" --------------------
" バッファ一覧
nnoremap <silent>fb :<C-u>Unite -start-insert buffer<CR>
" ファイル一覧
nnoremap <silent>ff :<C-u>UniteWithBufferDir -start-insert -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent>fr :<C-u>Unite -start-insert -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent>fm :<C-u>Unite -start-insert file_mru<CR>
" yank history
nnoremap <silent>fy :<C-u>Unite history/yank<CR>
aug unite
  au!
  " <C-c> then exit Unite
  au FileType unite imap <silent> <buffer> <C-c> <Plug>(unite_exit)
  au FileType unite nmap <silent> <buffer> <C-c> <Plug>(unite_exit)
aug END


" --------------------
" for "neocomplete" plugin
" --------------------
" Use neocomplete
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Lock neocom when multi byte character insertation
let g:neocomplete#lock_iminsert = 1
"let g:neocomplete#auto_completion_start_length = 3

" Enable omni completion.
aug neocomaug
  au!
  au FileType css setlocal omnifunc=csscomplete#CompleteCSS
  au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  au FileType python setlocal omnifunc=pythoncomplete#Complete
  au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
aug END

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" --------------------
" for "neosnippet" plugin
" --------------------
" Plugin key-mappings
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expend_target)


" SuperTab like snippets behavior.
"imap <expr><TAB> pumvisible() ? "\<C-n>" :
"  \ neosnippet#expandable_or_jumpable() ?
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory = '~/.vim/snippets'

" --------------------
" for "EnhCommentify" plugin
" --------------------
"let g:EnhCommentifyUserBindings = 'yes'

" --------------------
" template.vim
" --------------------
aug templatevimaug
  au!
  au FileType * execute 'TemplateLoad /filetype/' . &l:filetype
aug END

" --------------------
"  emmet.vim
" --------------------
let g:user_emmet_leader_key = '<C-m>'
let g:user_emmet_togglecomment_key = '<C-m>\/'

" --------------------
"  Alignta
" --------------------
vnoremap a: :<C-u>'<,'>Alignta 0:1 :<CR>
vnoremap a; :<C-u>'<,'>Alignta 0:1 ;<CR>
vnoremap a, :<C-u>'<,'>Alignta 0:1 ,<CR>
vnoremap a= :<C-u>'<,'>Alignta 1:1 =<CR>

" --------------------
"  NERDTree
" --------------------
let NERDTreeShowHidden = 1
nnoremap <Space>n :<C-u>NERDTreeToggle<CR>

" --------------------
"  vdebug
" --------------------
if has('gui_macvim')
  let g:vdebug_options['port'] = 9000
"let g:vdebug_keymap['get_context'] = '<F11>';
"let g:vdebug_keymap['eval_under_cursor'] = '<F12>';
endif

" custom scripts------------------------------------------------------------------
" --------------------
" 選択範囲を引数で受け取ったタグのリストにするスクリプト
" Author: Yasuo Fukuda (@sigwyg)
" http://archiva.jp/web/sugamo_css/sugamo_vim_01.html
" Modified by Naoki Sekiguchi
" --------------------
function! EleList(eleName) range
  let l:count = a:firstline
  while l:count <= a:lastline
    let l:str = getline(l:count)
    let l:out1 = substitute(l:str, '^\s\+', '', 'g')
    let l:out2 = '<' . a:eleName
    if a:eleName == 'option'
      let l:out2 .= ' value="0"'
    endif
    let l:out2 .= ('>' . l:out1 . '</' . a:eleName . '>')
    call setline(l:count, l:out2)
    let l:count = l:count + 1
  endwhile
"  call append(a:lastline, '</ul>')
"  call append(a:firstline - 1, '<ul>')
endfunction

vnoremap \td :call EleList("td")<CR>
vnoremap \th :call EleList("th")<CR>
vnoremap \li :call EleList("li")<CR>
vnoremap \op :call EleList("option")<CR>
vnoremap \dt :call EleList("dt")<CR>
vnoremap \dd :call EleList("dd")<CR>

function! EleLinkList(eleName) range
  let l:count = a:firstline
  while l:count <= a:lastline
    let l:str = getline(l:count)
    let l:out1 = substitute(l:str, '^\s\+', '', 'g')
    let l:out2 = '<' . a:eleName . '><a href="#">' . l:out1 . '</a></' . a:eleName . '>'
    call setline(l:count, l:out2)
    let l:count = l:count + 1
  endwhile
endfunction
vnoremap \tda :call EleLinkList("td")<CR>
vnoremap \tha :call EleLinkList("th")<CR>
vnoremap \lia :call EleLinkList("li")<CR>
vnoremap \dta :call EleLinkList("dt")<CR>
vnoremap \dda :call EleLinkList("dd")<CR>

function! LinkList() range
  let l:count = a:firstline
  while l:count <= a:lastline
    let l:str = getline(l:count)
    let l:out1 = substitute(l:str, '^\s\+', '', 'g')
    let l:out2 = '<a href="#">' . l:out1 . '</a>'
    call setline(l:count, l:out2)
    let l:count = l:count + 1
  endwhile
endfunction
vnoremap \ali :call LinkList()<CR>

" --------------------
" escape HTMl entities
" @url http://vim.wikia.com/wiki/HTML_entities
" --------------------
function! HtmlEscape()
  silent s/&/\&amp;/eg
  silent s/</\&lt;/eg
  silent s/>/\&gt;/eg
  silent s/"/\&quot;/eg
  silent s/'/\&#039;/eg
endfunction

function! HtmlUnEscape()
  silent s/&lt;/</eg
  silent s/&gt;/>/eg
  silent s/&quot;/"/eg
  silent s/&#039;/'/eg
  silent s/&amp;/\&/eg
endfunction

vnoremap <silent> ,e :call HtmlEscape()<CR>
vnoremap <silent> ,u :call HtmlUnEscape()<CR>

" --------------------
"  switch indent style
" --------------------
function! IndentStyle2() range
  setlocal shiftwidth=2
  setlocal tabstop=2
  setlocal expandtab
endfunction
function! IndentStyle4() range
  setlocal shiftwidth=4
  setlocal tabstop=4
  setlocal expandtab
endfunction
function! IndentStyleT() range
    setlocal shiftwidth=4
  setlocal tabstop=4
  setlocal noexpandtab
endfunction

nnoremap ,s2 :<C-u>call IndentStyle2()<CR>
nnoremap ,s4 :<C-u>call IndentStyle4()<CR>
nnoremap ,st :<C-u>call IndentStyleT()<CR>

" --------------------
"  quickfix: 編集許可と折り返し表示無効
" --------------------
function! OpenModifiableQF()
  cw
  set modifiable
  set nowrap
endfunction
aug qfaug
  au!
  au QuickfixCmdPost vimgrep call OpenModifiableQF()
aug END

" --------------------
"  autocmd
" --------------------
aug initaug
  au!
  " auto set current directory
  au BufEnter * execute ":lcd " . expand("%:p:h")
  " via file type
  au BufNewFile,BufRead *.vim call IndentStyle2()
  au BufNewFile,BufRead .vimrc call IndentStyle2()
  au BufNewFile,BufRead .gvimrc call IndentStyle2()
  au BufNewFile,BufRead Gruntfile.js call IndentStyle2()
  au BufNewFile,BufRead package.json call IndentStyle2()
  au BufNewFile,BufRead bower.json call IndentStyle2()
  au BufNewFile,BufRead *.coffee setf coffee | call IndentStyle2()
  au BufNewFile,BufRead *.ts setf typescript | call IndentStyle2()
  au BufNewFile,BufRead *.css call IndentStyle2()
  au BufNewFile,BufRead *.js call IndentStyle2() | set tags=~/.node_modules.tags
  au BufNewFile,BufRead *.php setf html | call IndentStyle2()
  au BufNewFile,BufRead *.scss setf scss | call IndentStyle2()
  au BufNewFile,BufRead *.less setf less | call IndentStyle2()
  au BufNewFile,BufRead *.styl setf stylus | call IndentStyle2()
  au BufNewFile,BufRead *.stylus setf stylus | call IndentStyle2()
  au BufNewFile,BufRead *.html call IndentStyleT()
  au BufNewFile,BufRead *.mtml setf html | call IndentStyleT()
aug END

