" https://qiita.com/delphinus/items/00ff2c0ba972c6e41542

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif


"dein Scripts-----------------------------
if &compatible
    set nocompatible
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " 元々のdeinのconfig
    "
    " Let dein manage dein
    " Required:
    "call dein#add('/home/admin/dotfiles/_vim/bundles/./repos/github.com/Shougo/dein.vim')
    "
    " Add or remove your plugins here:
    "call dein#add('Shougo/neosnippet.vim')
    "call dein#add('Shougo/neosnippet-snippets')
    "
    " You can specify revision/branch/tag.
    "call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })

    " ---
    let g:rc_dir    = expand('~/.vim/dein')
    let s:common_toml      = g:rc_dir . '/common.toml'
    let s:common_lazy_toml = g:rc_dir . '/common_lazy.toml'

    " tomlファイルをキャッシュ
    call dein#load_toml(s:common_toml,      {'lazy': 0})
    call dein#load_toml(s:common_lazy_toml, {'lazy': 1})

    " Required:
    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on
syntax enable

"End dein Scripts-------------------------
