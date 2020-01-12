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
    let g:rc_dir               = expand('~/.vim/dein')
    let s:common_toml          = g:rc_dir . '/common.toml'
    let s:git_toml             = g:rc_dir . '/git.toml'
    let s:appearance_toml      = g:rc_dir . '/appearance.toml'
    let s:denite_toml          = g:rc_dir . '/denite.toml'
    let s:lsp_toml             = g:rc_dir . '/lsp.toml'
    let s:common_lazy_toml     = g:rc_dir . '/common_lazy.toml'
    let s:ansible_lazy_toml    = g:rc_dir . '/ansible_lazy.toml'
    let s:terraform_lazy_toml  = g:rc_dir . '/terraform_lazy.toml'
    let s:markdown_lazy_toml   = g:rc_dir . '/markdown_lazy.toml'
    let s:golang_lazy_toml     = g:rc_dir . '/golang_lazy.toml'
    let s:python_lazy_toml     = g:rc_dir . '/python_lazy.toml'
    let s:typescript_lazy_toml = g:rc_dir . '/typescript_lazy.toml'
    let s:database_lazy_toml   = g:rc_dir . '/database_lazy.toml'
    let s:rust_lazy_toml       = g:rc_dir . '/rust_lazy.toml'

    " tomlファイルをキャッシュ
    call dein#load_toml(s:common_toml,          {'lazy': 0})
    call dein#load_toml(s:git_toml,             {'lazy': 0})
    call dein#load_toml(s:appearance_toml,      {'lazy': 0})
    call dein#load_toml(s:denite_toml,          {'lazy': 0})
    call dein#load_toml(s:lsp_toml,             {'lazy': 0})
    call dein#load_toml(s:common_lazy_toml,     {'lazy': 1})
    call dein#load_toml(s:ansible_lazy_toml,    {'lazy': 1})
    call dein#load_toml(s:terraform_lazy_toml,  {'lazy': 1})
    call dein#load_toml(s:markdown_lazy_toml,   {'lazy': 1})
    call dein#load_toml(s:golang_lazy_toml,     {'lazy': 1})
    call dein#load_toml(s:python_lazy_toml,     {'lazy': 1})
    call dein#load_toml(s:typescript_lazy_toml, {'lazy': 1})
    call dein#load_toml(s:database_lazy_toml,   {'lazy': 1})
    call dein#load_toml(s:rust_lazy_toml,       {'lazy': 1})

    " Required:
    call dein#end()
    call dein#save_state()
endif

" vimprocのみ先にインストール
if dein#check_install(['vimproc.vim'])
    call dein#install(['vimproc.vim'])
endif

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on
syntax enable

"End dein Scripts-------------------------
