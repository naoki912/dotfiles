" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!


" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2014 Nov 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

"syntax
autocmd FileType c :set dictionary=/usr/share/vim/vim74/syntax/c.vim
autocmd FileType java :set dictionary=/usr/share/vim/vim74/syntax/java.vim

"path
let $PATH = "~/.pyenv/shims:".$PATH


"########## Tab ##########
"http://qiita.com/wadako111/items/755e753677dd72d8036d
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
"map <silent> [Tag]n :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]l :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
map <silent> [Tag]h :tabprevious<CR>
" tp 前のタブ



"############ my config ##################
"### 必須設定 ###
" release autogroup in MyAutoCmd
augroup MyAutoCmd
    autocmd!
augroup END

"### 検索関係 ###
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正)

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"### 編集関係 ###
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
"set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
"set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
"set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus,unnamed
else
    set clipboard& clipboard+=unnamed
endif

" SwapファイルBackupファイル無効
set nowritebackup
set nobackup
set noswapfile

"### 表示関係 ###
"set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる

set breakindent         " インデントがある長い行の折り返しが綺麗になるやつ

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
"set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

"### マクロおよびキー設定 ###
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
                \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif

"### その他個人設定 ###
set number
"set ts=4 sw=4 sts=0
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

set guifont=RictyDiscord\ Regular\ 12
set autoindent
set smartindent
filetype plugin on
syntax on
set cursorline
set noundofile

colorscheme molokai

"背景の透過
highlight Normal  ctermbg=NONE
highlight NonText ctermbg=NONE

" コマンドモードで;で:を読みだす
nnoremap ; :
nnoremap <S-y> <C-e>

" like Emacs
imap <C-a> <Home>
imap <C-e> <End>

" 自動的に閉じ括弧を入力
"imap { {}<LEFT>
"imap [ []<LEFT>
"imap ( ()<LEFT>

"Abbreviation
ab #[ /****************************************
ab #] *****************************************/
ab #/ /////////////////////////////////////////
ab #i #include <stdio.h>
ab #p #!/usr/bin/python
ab #s #!/bin/sh

" color
if $TERM == '*256*'
    set t_Co=256
endif

"### プラギン設定 ###
" PATHの自動更新関数
" | 指定された path が $PATH に存在せず、ディレクトリとして存在している場合
" | のみ $PATH に加える
function! IncludePath(path)
  " define delimiter depends on platform
  if has('win16') || has('win32') || has('win64')
    let delimiter = ";"
  else
    let delimiter = ":"
  endif
  let pathlist = split($PATH, delimiter)
  if isdirectory(a:path) && index(pathlist, a:path) == -1
    let $PATH=a:path.delimiter.$PATH
  endif
endfunction

" ~/.pyenv/shims を $PATH に追加する
" これを行わないとpythonが正しく検索されない
call IncludePath(expand("~/.pyenv/shims"))


let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
if !isdirectory(s:neobundle_root) || v:version < 702
    " NeoBundleが存在しない、もしくはVimのバージョンが古い場合はプラグインを一切
    " 読み込まない
    let s:noplugin = 1
else
    " NeoBundleを'runtimepath'に追加し初期化を行う
    if has('vim_starting')
        execute "set runtimepath+=" . s:neobundle_root
    endif
    call neobundle#begin(s:bundle_root)

    " NeoBundle自身をNeoBundleで管理させる
    NeoBundleFetch 'Shougo/neobundle.vim'

    "##### セッション関連 #####
    NeoBundle 'tpope/vim-obsession'

    "##### ファイル管理関係 #####

    "### vim-templateによるテンプレートファイルの使用 ###
    NeoBundle "thinca/vim-template"
    " テンプレート中に含まれる特定文字列を置き換える
    autocmd MyAutoCmd User plugin-template-loaded call s:template_keywords()
    function! s:template_keywords()
        silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
        silent! %s/<+FILENAME+>/\=expand('%:r')/g
    endfunction
    " テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
    autocmd MyAutoCmd User plugin-template-loaded
                \   if search('<+CURSOR+>')
                \ |   silent! execute 'normal! "_da>'
                \ | endif
    """ 使用方法
    " ~/.vim/template 内に、template.pyのように保存

    "### Unite.vimによる総合管理 ###
    NeoBundleLazy "Shougo/unite.vim", {
                \ "autoload": {
                \   "commands": ["Unite", "UniteWithBufferDir"]
                \ }}
    NeoBundleLazy 'h1mesuke/unite-outline', {
                \ "autoload": {
                \   "unite_sources": ["outline"],
                \ }}
    nnoremap [unite] <Nop>
    nmap U [unite]
    nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
    nnoremap <silent> [unite]r :<C-u>Unite register<CR>
    nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
    nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
    nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
    nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
    nnoremap <silent> [unite]w :<C-u>Unite window<CR>
    let s:hooks = neobundle#get_hooks("unite.vim")
    function! s:hooks.on_source(bundle)
        " start unite in insert mode
        let g:unite_enable_start_insert = 1
        " use vimfiler to open directory
        call unite#custom_default_action("source/bookmark/directory", "vimfiler")
        call unite#custom_default_action("directory", "vimfiler")
        call unite#custom_default_action("directory_mru", "vimfiler")
        autocmd MyAutoCmd FileType unite call s:unite_settings()
        function! s:unite_settings()
            imap <buffer> <Esc><Esc> <Plug>(unite_exit)
            nmap <buffer> <Esc> <Plug>(unite_exit)
            nmap <buffer> <C-n> <Plug>(unite_select_next_line)
            nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
        endfunction
    endfunction

    "### Vimfilerによる開発環境実装
    NeoBundleLazy "Shougo/vimfiler", {
                \ "depends": ["Shougo/unite.vim"],
                \ "autoload": {
                \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
                \   "mappings": ['<Plug>(vimfiler_switch)'],
                \   "explorer": 1,
                \ }}
    nnoremap <silent><C-e> :VimFilerExplorer<CR>
    nnoremap <Leader>e :VimFilerExplorer<CR>
    " close vimfiler automatically when there are only vimfiler open
    autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
    let s:hooks = neobundle#get_hooks("vimfiler")
    function! s:hooks.on_source(bundle)
        let g:vimfiler_as_default_explorer = 1
        let g:vimfiler_enable_auto_cd = 1

        " .から始まるファイルおよび.pycで終わるファイルを不可視パターンに
        " 2013-08-14 追記
        let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"

        " vimfiler specific key mappings
        autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
        function! s:vimfiler_settings()
            " ^^ to go up
            nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
            " use R to refresh
            nmap <buffer> R <Plug>(vimfiler_redraw_screen)
            " overwrite C-l
            nmap <buffer> <C-l> <C-w>l
        endfunction
    endfunction

    "##### テキスト編集関係 #####

    "### 囲まれているものに対していろいろする ###
    NeoBundle 'tpope/vim-surround'
    "### テキスト整形用プラギン ###
    NeoBundle 'vim-scripts/Align'
    "### 'p'によるペースト後Ctrl-p,Ctrl-nで履歴と置き換え
    NeoBundle 'vim-scripts/YankRing.vim'

    "### neocomplete補完 ###
    " if has('lua') && v:version > 703 && has('patch825') 2013-07-03 14:30 > から >= に修正
    " if has('lua') && v:version >= 703 && has('patch825') 2013-07-08 10:00 必要バージョンが885にアップデートされていました
    if has('lua') && v:version >= 703 && has('patch885')
        NeoBundleLazy "Shougo/neocomplete.vim", {
                    \ "autoload": {
                    \   "insert": 1,
                    \ }}
        " 2013-07-03 14:30 NeoComplCacheに合わせた
        let g:neocomplete#enable_at_startup = 1
        let s:hooks = neobundle#get_hooks("neocomplete.vim")
        function! s:hooks.on_source(bundle)
            let g:acp_enableAtStartup = 0
            let g:neocomplet#enable_smart_case = 1
            " NeoCompleteを有効化
            " NeoCompleteEnable

            "let g:neocomplete#sources#syntax#min_keyword_length = 3
            "let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
            " Plugin key-mappings.
            inoremap <expr><C-g>     neocomplete#undo_completion()
            inoremap <expr><C-l>     neocomplete#complete_common_string()
            inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
            function! s:my_cr_function()
                return neocomplete#close_popup() . "\<CR>"
                return pumvisible() ? neocomplete#close_popup() : "\<CR>"
            endfunction
            inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
            inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
            inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
            inoremap <expr><C-y>  neocomplete#close_popup()
            inoremap <expr><C-e>  neocomplete#cancel_popup()
            " ポップアップを<Space>で消す
            "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

        endfunction
    else
        NeoBundleLazy "Shougo/neocomplcache.vim", {
                    \ "autoload": {
                    \   "insert": 1,
                    \ }}
        " 2013-07-03 14:30 原因不明だがNeoComplCacheEnableコマンドが見つからないので変更
        let g:neocomplcache_enable_at_startup = 1
        let s:hooks = neobundle#get_hooks("neocomplcache.vim")
        function! s:hooks.on_source(bundle)
            let g:acp_enableAtStartup = 0
            let g:neocomplcache_enable_smart_case = 1
            " NeoComplCacheを有効化
            " NeoComplCacheEnable
        endfunction
    endif

    "### neosnippetコード入力の簡略化 ###
    NeoBundleLazy "Shougo/neosnippet.vim", {
                \ "depends": ["honza/vim-snippets"],
                \ "autoload": {
                \   "insert": 1,
                \ }}
    NeoBundle 'Shougo/neosnippet-snippets'
    let s:hooks = neobundle#get_hooks("neosnippet.vim")
    function! s:hooks.on_source(bundle)
        " Plugin key-mappings.
        imap <C-k>     <Plug>(neosnippet_expand_or_jump)
        smap <C-k>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-k>     <Plug>(neosnippet_expand_target)
        " SuperTab like snippets behavior.
        imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                    \ "\<Plug>(neosnippet_expand_or_jump)"
                    \: pumvisible() ? "\<C-n>" : "\<TAB>"
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                    \ "\<Plug>(neosnippet_expand_or_jump)"
                    \: "\<TAB>"
        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif
        " Enable snipMate compatibility feature.
        let g:neosnippet#enable_snipmate_compatibility = 1
        " Tell Neosnippet about the other snippets
        let g:neosnippet#snippets_directory=s:bundle_root . '/vim-snippets/snippets'
    endfunction

    "### インデントに色を付けて見やすくする ###
    NeoBundle "nathanaelkane/vim-indent-guides"
    let s:hooks = neobundle#get_hooks("vim-indent-guides")
    function! s:hooks.on_source(bundle)
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
        "IndentGuidesEnable
    endfunction

    "### Gundo.vimによる高機能アンドゥ実装 ###
    NeoBundleLazy "sjl/gundo.vim", {
                \ "autoload": {
                \   "commands": ['GundoToggle'],
                \}}
    nnoremap <Leader>g :GundoToggle<CR>

    "### TaskList.vim ToDo管理
    NeoBundleLazy "vim-scripts/TaskList.vim", {
                \ "autoload": {
                \   "mappings": ['<Plug>TaskList'],
                \}}
    nmap <Leader>T <plug>TaskList

    "##### プログラミング関係 #####

    "### quickrunによる即時実行 ###
    NeoBundleLazy "thinca/vim-quickrun", {
                \ "autoload": {
                \   "mappings": [['nxo', '<Plug>(quickrun)']]
                \ }}
    nmap <Leader>r <Plug>(quickrun)
    let s:hooks = neobundle#get_hooks("vim-quickrun")
    function! s:hooks.on_source(bundle)
        let g:quickrun_config = {
                    \ "*": {"runner": "vimproc"},
                    \ }
   endfunction

   "### Tarbarによるクラスアウトライン
   NeoBundleLazy 'majutsushi/tagbar', {
               \ "autload": {
               \   "commands": ["TagbarToggle"],
               \ },
               \ "build": {
               \   "mac": "brew install ctags",
               \   "unix": "pacman -S ctags",
               \ }}
   nmap <Leader>t :TagbarToggle<CR>
   " Exuberant ctags必須

   "### syntastic 構文エラー表示
   NeoBundle "scrooloose/syntastic", {
               \ "build": {
               \   "mac": ["pip install flake8", "npm -g install coffeelint"],
               \   "unix": ["pip install flake8", "npm -g install coffeelint"],
               \ }}

    "##### Python関係 #####

    "### vimでpythonのコーディングスタイルを自動でチェック&自動修正する
    " http://ton-up.net/technote/2013/11/26/vim-python-style-check-and-fix/

    NeoBundle 'scrooloose/syntastic'
    "let g:syntastic_python_checkers = ['pyflakes', 'pep8']
    let g:syntastic_python_checkers = ['flake8']

    NeoBundle 'tell-k/vim-autopep8'
    autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
    " 79文字制限をとりあえず200にして解除, -1が使えるかどうかは未検証
    let g:autopep8_max_line_length=200

    "### virtualenvとdjango問題の解決 ###
    " Djangoを正しくVimで読み込めるようにする
    NeoBundleLazy "lambdalisue/vim-django-support", {
                \ "autoload": {
                \   "filetypes": ["python", "python3", "djangohtml"]
                \ }}
    " Vimで正しくvirtualenvを処理できるようにする
    NeoBundleLazy "jmcantrell/vim-virtualenv", {
                \ "autoload": {
                \   "filetypes": ["python", "python3", "djangohtml"]
                \ }}

    "### jedi-vim python補完・リファクタリング・リファレンス環境 ###
    NeoBundleLazy "davidhalter/jedi-vim", {
                \ "autoload": {
                \   "filetypes": ["python", "python3", "djangohtml"],
                \ },
                \ "build": {
                \   "mac": "pip install jedi",
                \   "unix": "pip install jedi",
                \ }}
    let s:hooks = neobundle#get_hooks("jedi-vim")
    function! s:hooks.on_source(bundle)
        " jediにvimの設定を任せると'completeopt+=preview'するので
        " 自動設定機能をOFFにし手動で設定を行う
        let g:jedi#auto_vim_configuration = 0
        " 補完の最初の項目が選択された状態だと使いにくいためオフにする
        let g:jedi#popup_select_first = 0
        " quickrunと被るため大文字に変更
        let g:jedi#rename_command = '<Leader>R'
        " gundoと被るため大文字に変更 (2013-06-24 10:00 追記）
        let g:jedi#goto_command = '<Leader>G'
        " docstringは表示しない
        autocmd FileType python setlocal completeopt-=preview
    endfunction
    " 補完用設定
    NeoBundleLazy "lambdalisue/vim-pyenv", {
                \ "depends": ['davidhalter/jedi-vim'],
                \ "autoload": {
                \   "filetypes": ["python", "python3", "djangohtml"]
                \ }}

    NeoBundle 'davidhalter/jedi-vim'

    "### コメントを操作するプラギン ###
    NeoBundle 'scrooloose/nerdcommenter'
    let NERDSpaceDelims = 1
    nmap ,, <Plug>NERDCommenterToggle
    vmap ,, <Plug>NERDCommenterToggle
    " 行の最後にコメントを追加
    nmap ,a <Plug>NERDCommenterAppend
    " カーソルの位置から行の最後までをコメントに変更
    nmap ,9 <Plug>NERDCommenterToEOL
    nmap ,s <Plug>NERDCommenterSexy
    vmap ,s <Plug>NERDCommenterSexy
    nmap ,b <Plug>NERDCommenterMinima
    vmap ,b <Plug>NERDCommenterMinima

    "### 行末の不要な半角スペースを可視化 ###
    NeoBundle 'bronson/vim-trailing-whitespace'
    nmap d<TAB> :FixWhitespace<CR>

    " https://github.com/ujihisa/repl.vim
    NeoBundle 'ujihisa/repl.vim'

    "##### golang #####
    NeoBundle 'fatih/vim-go'
    " let g:neocomplete#sources#omni#input_patterns.go = '\h\w\.\w*'
    " autocmd FileType go :highlight goErr cterm=bold ctermfg=214
    " autocmd FileType go :match goErr /\<err\>/

    "##### ドキュメント関連 #####

    "### vim-pandoc markdownとかのシンタックス・インデント用
    NeoBundleLazy "vim-pandoc/vim-pandoc", {
                \ "autoload": {
                \   "filetypes": ["text", "pandoc", "markdown", "rst", "textile"],
                \ }}

    "##### 見た目 #####
    NeoBundle 'itchyny/lightline.vim'
    let g:lightline = {
                \ 'colorscheme': 'wombat',
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ], [ 'pyenv' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
                \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
                \ },
                \ 'component_function': {
                \   'fugitive': 'MyFugitive',
                \   'filename': 'MyFilename',
                \   'fileformat': 'MyFileformat',
                \   'filetype': 'MyFiletype',
                \   'fileencoding': 'MyFileencoding',
                \   'mode': 'MyMode',
                \   'ctrlpmark': 'CtrlPMark',
                \   'pyenv' : 'MyPyenv',
                \ },
                \ 'component_expand': {
                \   'syntastic': 'SyntasticStatuslineFlag',
                \ },
                \ 'component': {
                \ },
                \ 'component_type': {
                \   'syntastic': 'error',
                \ },
                \ 'subseparator': { 'left': '|', 'right': '|' }
                \ }
                " \   'pyenv' : 'pyenv#statusline#component',
    function! MyPyenv()
        " return pyenv#info#format('%ss %iv %ev')
        return pyenv#info#preset('long')
    endfunction

    function! MyModified()
        return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! MyReadonly()
        return &ft !~? 'help' && &readonly ? 'RO' : ''
    endfunction

    function! MyFilename()
        let fname = expand('%:t')
        return fname == 'ControlP' ? g:lightline.ctrlp_item :
                    \ fname == '__Tagbar__' ? g:lightline.fname :
                    \ fname =~ '__Gundo\|NERD_tree' ? '' :
                    \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
                    \ &ft == 'unite' ? unite#get_status_string() :
                    \ &ft == 'vimshell' ? vimshell#get_status_string() :
                    \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                    \ ('' != fname ? fname : '[No Name]') .
                    \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction

    function! MyFugitive()
        try
            if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
                let mark = ''  " edit here for cool mark
                let _ = fugitive#head()
                return strlen(_) ? mark._ : ''
            endif
        catch
        endtry
        return ''
    endfunction

    function! MyFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    function! MyFiletype()
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction

    function! MyFileencoding()
        return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! MyMode()
        let fname = expand('%:t')
        return fname == '__Tagbar__' ? 'Tagbar' :
                    \ fname == 'ControlP' ? 'CtrlP' :
                    \ fname == '__Gundo__' ? 'Gundo' :
                    \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
                    \ fname =~ 'NERD_tree' ? 'NERDTree' :
                    \ &ft == 'unite' ? 'Unite' :
                    \ &ft == 'vimfiler' ? 'VimFiler' :
                    \ &ft == 'vimshell' ? 'VimShell' :
                    \ winwidth(0) > 60 ? lightline#mode() : ''
    endfunction

    function! CtrlPMark()
        if expand('%:t') =~ 'ControlP'
            call lightline#link('iR'[g:lightline.ctrlp_regex])
            return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                        \ , g:lightline.ctrlp_next], 0)
        else
            return ''
        endif
    endfunction

    let g:ctrlp_status_func = {
                \ 'main': 'CtrlPStatusFunc_1',
                \ 'prog': 'CtrlPStatusFunc_2',
                \ }

    function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
        let g:lightline.ctrlp_regex = a:regex
        let g:lightline.ctrlp_prev = a:prev
        let g:lightline.ctrlp_item = a:item
        let g:lightline.ctrlp_next = a:next
        return lightline#statusline(0)
    endfunction

    function! CtrlPStatusFunc_2(str)
        return lightline#statusline(0)
    endfunction

    let g:tagbar_status_func = 'TagbarStatusFunc'

    function! TagbarStatusFunc(current, sort, fname, ...) abort
        let g:lightline.fname = a:fname
        return lightline#statusline(0)
    endfunction

    augroup AutoSyntastic
        autocmd!
        autocmd BufWritePost *.c,*.cpp call s:syntastic()
    augroup END
    function! s:syntastic()
        SyntasticCheck
        call lightline#update()
    endfunction

    let g:unite_force_overwrite_statusline = 0
    let g:vimfiler_force_overwrite_statusline = 0
    let g:vimshell_force_overwrite_statusline = 0

    " ToDo Git関連の設定
    NeoBundleCheck

endif

call neobundle#end()


" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
set laststatus=2
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=black ctermbg=yellow cterm=none'
if has('syntax')
    augroup InsertHook
        autocmd!
        autocmd InsertEnter * call s:StatusLine('Enter')
        autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
endif
let s:slhlcmd = ''
function! s:StatusLine(mode)
    if a:mode == 'Enter'
        silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
        silent exec g:hi_insert
    else
        highlight clear StatusLine
        silent exec s:slhlcmd
    endif
endfunction
function! s:GetHighlight(hi)
    redir => hl
    exec 'highlight '.a:hi
    redir END
    let hl = substitute(hl, '[\r\n]', '', 'g')
    let hl = substitute(hl, 'xxx', '', '')
    return hl
endfunction
""""""""""""""""""""""""""""""

filetype plugin indent on
syntax on


" 自分のvimrcが読めない

" vim-go
"" mapping
""" go runのキーマッピング
au FileType go nmap gr (go-run)
""" go testのキーマッピング
au FileType go nmap gt (go-test)
"" highlight
let g:go_hightlight_functions = 1
let g:go_hightlight_methods = 1
let g:go_hightlight_structs = 1
let g:go_hightlight_interfaces = 1
let g:go_hightlight_operators = 1
let g:go_hightlight_build_constraints = 1
"" GoFmt時にインポートするパッケージを整理(GoFmtはファイル書き込み時に自動的に実行される)
let g:go_fmt_command = "goimports"

"""""

" vp doesn't replace paste buffer
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

"""
" うまく動かない
" 12G じゃなくて、12Enterを叩くと12行目に移動できる
"nnoremap <CR> G
"nnoremap <BS> gg
nnoremap <CR> G
" 間違った時用に元の位置に戻るやつを入れたいんだけど、 <C-BS> が動かない
"nnoremap <C-CR> <C-o>
"nnoremap <C-BS> <C-i>
nnoremap <BS> <C-o>
nnoremap <C-BS> <C-i>

" shift+o キーで改行を挿入する
"nnoremap O :<C-u>call append(expand('.'), '')<Cr>j


" Jqコマンド
" jqでjsonをいい感じに整形する
" :Jq
" :Jq .obj.list
" https://qiita.com/tekkoc/items/324d736f68b0f27680b8
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction
