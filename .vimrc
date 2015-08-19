version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim

if has('win32')
  set runtimepath+=D:\My\ Dropbox\vimfiles
elseif has('gui_macvim')
  set runtimepath+=$HOME/Dropbox/vimfiles
else
  set runtimepath+=$HOME/Dropbox/vimfiles
endif

" $VIMRUNTIME directory resetting
if has('win32')
  let $VF = 'D:/My\ Dropbox/vimfiles'
  let $HTDOCS = 'D:/htdocs'
elseif has('gui_macvim')
  let $VF = $HOME . '/Dropbox/vimfiles'
  let $HTDOCS = $HOME.'/Sites'
else
  let $VF = $HOME . '/Dropbox/vimfiles'
  let $HTDOCS = $HOME.'/Sites'
endif

" for "Vundle" plugin
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

"
" My Bundles here:
"
" original repos on github
" Framework & Library
Bundle 'git-mirror/vim-l9'
Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-operator-user'

Bundle 'Shougo/unite.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'thinca/vim-template'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-qfreplace'
Bundle 'hrp/EnhancedCommentify'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'vim-scripts/autodate.vim'
Bundle 'h1mesuke/vim-alignta.git'
Bundle 'edsono/vim-matchit'
Bundle 'mattn/emmet-vim'
Bundle 'thinca/vim-quickrun.git'
Bundle 'editorconfig/editorconfig-vim'

" PHP Debug
Bundle 'joonty/vdebug.git'
" Coffee Script
Bundle 'kchmck/vim-coffee-script'

Bundle 'jiangmiao/simple-javascript-indenter'
Bundle 'jelera/vim-javascript-syntax'

" Syntax
Bundle 'tpope/vim-haml'
Bundle 'groenewege/vim-less'
Bundle 'wavded/vim-stylus'
Bundle 'digitaltoad/vim-jade'


" vim-scripts repos
"Bundle '';

filetype plugin indent on     " required! 
"
" Brief help
"
" :BundleInstall  - install bundles (won't update installed)
" :BundleInstall! - update if installed
"
" :Bundles foo    - search for foo
" :Bundles! foo   - refresh cached list and search for foo
"
" :BundleClean    - confirm removal of unused bundles
" :BundleClean!   - remove without confirmation
"
" see :h vundle for more details
" or wiki for FAQ
" Note: comments after Bundle command are not allowed..

set title

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
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc)(&bomb?':BOM':'').']['.&ff.']'}%=%l,%c%V%8P
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
"set foldmarker="{{{,}}}"

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

" --------------------
" for some plugin
" "snipMate.vim", "Align.vim"
" --------------------
filetype on
filetype plugin on
"set runtimepath+=$VIMRUNTIME/after
if has('win32')
  let snippets_dir='D:/My\ Dropbox/vimfiles/snippets'
elseif has('gui_macvim')
  let snippets_dir=$HOME . '/Dropbox/vimfiles/snippets'
endif

" file and directory---------------------------------------------------------------

" shortcut for vim config files
nnoremap <Space>. <Esc>:<C-u>source ~/dotfiles/.vimrc<CR>:<C-u>source ~/dotfiles/.gvimrc<CR>
nnoremap <Space>v :e ~/dotfiles/.vimrc<CR>
nnoremap <Space>g :e ~/dotfiles/.gvimrc<CR>
if has('win32') || has('win64')
  nnoremap <Space>sh :e D:/My Dropbox/vimfiles/snippets/html.snippets<CR>
  nnoremap <Space>sp :e D:/My Dropbox/vimfiles/snippets/php.snippets<CR>
  nnoremap <Space>sc :e D:/My Dropbox/vimfiles/snippets/css.snippets<CR>
  nnoremap <Space>ss :e D:/My Dropbox/vimfiles/snippets/scss.snippets<CR>
  nnoremap <Space>sl :e D:/My Dropbox/vimfiles/snippets/less.snippets<CR>
  nnoremap <Space>sj :e D:/My Dropbox/vimfiles/snippets/javascript.snippets<CR>
  nnoremap <Space>h :e C:/WINDOWS/system32/drivers/etc/hosts<CR>
  nnoremap <Space>vh :e C:/xampp/apache/conf/extra/httpd-vhosts.conf<CR>
  "if has('kaoriya')
  "endif
elseif has('gui_macvim')
"    nnoremap <Space>. <Esc>:<C-u>source $HOME/Dropbox/vimfiles/vimrc.vim<CR>:<C-u>source $HOME/Dropbox/vimfiles/gvimrc.vim<CR>
  nnoremap <Space>sh :e $HOME/Dropbox/vimfiles/snippets/html.snippets<CR>
  nnoremap <Space>sp :e $HOME/Dropbox/vimfiles/snippets/php.snippets<CR>
  nnoremap <Space>sc :e $HOME/Dropbox/vimfiles/snippets/css.snippets<CR>
  nnoremap <Space>ss :e $HOME/Dropbox/vimfiles/snippets/scss.snippets<CR>
  nnoremap <Space>sl :e $HOME/Dropbox/vimfiles/snippets/less.snippets<CR>
  nnoremap <Space>sj :e $HOME/Dropbox/vimfiles/snippets/javascript.snippets<CR>
  nnoremap <Space>h :e /etc/hosts<CR>
  nnoremap <Space>log :<C-u>e /Applications/XAMPP/xamppfiles/logs<CR>
endif

" keymap---------------------------------------------------------------------------
" shortcut for help
nnoremap <C-h> :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><Enter>

map! <S-Insert> <MiddleMouse>
vmap  "*d

map Q gq
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetBrowseX(expand("<cWORD>"),0)
vmap <C-Del> "*d
vmap <S-Del> "*d
vmap <C-Insert> "*y

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

map <S-Insert> <MiddleMouse>
inoremap <C-H> <Left>
inoremap <NL> <Down>
inoremap <C-K> <Up>
inoremap <C-L> <Right>
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
noremap <CR> i<S-CR><Esc>

nnoremap * y/<C-r>0<CR>
nnoremap vv v$h

"set file encoding
nnoremap ,enu :<C-u>set fenc=utf8<CR>
nnoremap ,enc :<C-u>set fenc=cp932<CR>

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

" for plugins----------------------------------------------------------------------
" --------------------
" for "Autodate" plugin
" --------------------
let autodate_format = '%Y-%m-%d %H:%M:%S'
let autodate_keyword_pre = '\cUpdate\s\s'

" --------------------
" for "Simple Javascript Indenter" plugin
" --------------------
let g:SimpleJsIndenter_BriefMode = 1

" --------------------
" for "unite.vim" plugin
" --------------------
" インサートモードで開始
let g:unite_enable_start_insert = 1
" バッファ一覧
nnoremap <silent>fb :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent>ff :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent>fr :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent>fm :<C-u>Unite file_mru<CR>

" --------------------
" for "neocomplcache" plugin
" --------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><C-CR>  neocomplcache#smart_close_popup() . "\<CR>"

" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

" Lock neocom when multi byte character insertation
let g:neocomplcache_lock_iminsert = 1
let g:neocomplcache_auto_completion_start_length = 3

" Enable omni completion.
aug neocomaug
  au!
  au FileType css setlocal omnifunc=csscomplete#CompleteCSS
  au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  au FileType python setlocal omnifunc=pythoncomplete#Complete
  au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
aug END

" --------------------
" for "EnhCommentify" plugin
" --------------------
"let g:EnhCommentifyUserBindings = 'yes'

" --------------------
" for "ref.vim" plugin
" --------------------
if has('win32')
"    let g:ref_phpmanual_path = $HOME . '/My Dropbox/Document/php-chunked-xhtml'
  let g:ref_phpmanual_path = 'd:/php-chunked-xhtml'
elseif has('gui_macvim')
"    let g:ref_phpmanual_path = $HOME/Dropbox/vimfiles/doc/php-bigxhtml.html
endif

" --------------------
" for "yankring.vim" plugin
" --------------------
let g:yankring_n_keys = 'Y D'


" --------------------
" template.vim
" --------------------
if has('gui_macvim')
"    g:template_basedir=~/Dropbox/vimfiles
endif

aug templatevimaug
  au!
  au FileType * execute 'TemplateLoad /filetype/' . &l:filetype
aug ENd

" --------------------
" for "surround.vim" plugin
" Author: Kazuhito Hokamura (@hokaccha)
" http://webtech-walker.com/archive/2009/02/08031540.html
" --------------------
" [key map]
" 1 : <h1>|</h1>
" 2 : <h2>|</h2>
" 3 : <h3>|</h3>
" 4 : <h4>|</h4>
" 5 : <h5>|</h5>
" 6 : <h6>|</h6>
"
" p : <p>|</p>
" u : <ul>|</ul>
" o : <ol>|</ol>
" l : <li>|</li>
" a : <a href="">|</a>
" A : <a href="|"></a>
" i : <img src="|" alt="" />
" I : <img src="" alt"|" />
" d : <div>|</div>
" D : <div class="section">|</div>

aug surroundvimaug
  au!
  au FileType html let b:surround_49  = "<h1>\r</h1>"
  au FileType html let b:surround_50  = "<h2>\r</h2>"
  au FileType html let b:surround_51  = "<h3>\r</h3>"
  au FileType html let b:surround_52  = "<h4>\r</h4>"
  au FileType html let b:surround_53  = "<h5>\r</h5>"
  au FileType html let b:surround_54  = "<h6>\r</h6>"

  au FileType html let b:surround_112 = "<p>\r</p>"
  au FileType html let b:surround_117 = "<ul>\r</ul>"
  au FileType html let b:surround_111 = "<ol>\r</ol>"
  au FileType html let b:surround_108 = "<li>\r</li>"
  au FileType html let b:surround_97  = "<a href=\"\">\r</a>"
  au FileType html let b:surround_65  = "<a href=\"\r\"></a>"
  au FileType html let b:surround_105 = "<img src=\"\r\" alt=\"\" />"
  au FileType html let b:surround_73  = "<img src=\"\" alt=\"\r\" />"
  au FileType html let b:surround_100 = "<div>\r</div>"
  au FileType html let b:surround_68  = "<div class=\"section\">\r</div>"
aug END

" --------------------
" "copypath.vim"
" --------------------
let g:copypath_copy_to_unnamed_register = 1

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
"  call append(a:lastline, '</ul>')
"  call append(a:firstline - 1, '<ul>')
endfunction
vnoremap \tda :call EleLinkList("td")<CR>
vnoremap \tha :call EleLinkList("th")<CR>
vnoremap \lia :call EleLinkList("li")<CR>
vnoremap \dta :call EleLinkList("dt")<CR>
vnoremap \dda :call EleLinkList("dd")<CR>

"vnoremap ,ap s<a href="<s-Insert>"><CR><Esc>

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
" snipMate.vim のsnippetを書いた時点で再読み込みする
" Author: Kazuhito Hokamura (@hokaccha)
" http://webtech-walker.com/archive/2009/10/26021358.html
" --------------------
function! SnipMateReload()
  if &ft == 'snippet'
    let ft = substitute(expand('%'), '.snippets', '', '')
    if has_key(g:did_ft, ft)
      unlet g:did_ft[ft]
    endif
    silent! call GetSnippets(g:snippets_dir, ft)
  endif
endfunction


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
"  html5validator.vim
" --------------------
nnoremap \v :<C-u>HTML5Validate<CR>

" --------------------
"  emmet.vim
" --------------------
let g:user_emmet_leader_key = '<C-m>'
let g:user_emmet_togglecomment_key = '<C-m>\/'


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
"  vdebug
" --------------------
let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000


" temp setting
" --------------------------------------------------------------------------
if has('win32')
  nnoremap <Space>m <Esc>:<C-u>e D:/My\ Dropbox/memo.txt<CR>
elseif has('gui_macvim')
  nnoremap <Space>m <Esc>:<C-u>e $HOME/Dropbox/memo.txt<CR>
endif


" --------------------
"  autocmd
" --------------------
aug initaug
  au!
  " auto set current directory
  au BufEnter * execute ":lcd " . expand("%:p:h")
  " for file path that starts with slash 
  " http://hail2u.net/blog/software/only-one-line-life-changing-vimrc-setting.html
  au FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
  " via file type
  au BufNewFile,BufRead *.vim call IndentStyle2()
  au BufNewFile,BufRead .vimrc call IndentStyle2()
  au BufNewFile,BufRead .gvimrc call IndentStyle2()
  au BufNewFile,BufRead Gruntfile.js call IndentStyle2()
  au BufNewFile,BufRead package.json call IndentStyle2()
  au BufNewFile,BufRead bower.json call IndentStyle2()
  au BufNewFile,BufRead *.coffee setf coffee | call IndentStyle2()
  au BufNewFile,BufRead *.html call IndentStyleT()
  au BufNewFile,BufRead *.css call IndentStyle2()
  au BufNewFile,BufRead *.js call IndentStyle2()
  au BufNewFile,BufRead *.mtml setf html | call IndentStyleT()
  au BufNewFile,BufRead *.php setf html | call IndentStyle2()
  au BufNewFile,BufRead *.scss setf scss | call IndentStyle2()
  au BufNewFile,BufRead *.less setf less | call IndentStyle2()
  au BufNewFile,BufRead *.styl setf stylus | call IndentStyle2()
  au BufNewFile,BufRead *.stylus setf stylus | call IndentStyle2()
aug END
