let mapleader = "\<Space>"


" http://postd.cc/how-to-boost-your-vim-productivity/

" <Space>oを押して新しいファイルを開く
nnoremap <Leader>o :CtrlP<CR>

" <Space>wを押してファイルを保存する（:w<Enter>よりずっと速い）
nnoremap <Leader>w :w<CR>

" <Space>pと<Space>yでシステムのクリップボードにコピー＆ペーストする
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" <Space><Space>でビジュアルラインモードに切り替える
nmap <Leader><Leader> V

