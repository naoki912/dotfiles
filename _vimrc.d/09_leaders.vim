let mapleader = "\<Space>"

" [wLeader] に<Leader><Leader>を割り当て
" `<Leader><Leader>と2回入力 == [wLeader]`
nnoremap [wLeader] <Nop>
nmap <Leader><Leader> [wLeader]


" http://postd.cc/how-to-boost-your-vim-productivity/

" <Space>wを押してファイルを保存する（:w<Enter>よりずっと速い）
nnoremap <Leader>w :w<CR>

" <Space>pと<Space>yでシステムのクリップボードにコピー＆ペーストする
" CLIPBOARD, PRIMARYの違い https://oplern.hatenablog.com/entry/2017/04/10/070433
" CLIPBOARD
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader>gp "+gp
nmap <Leader>gP "+gP
vmap <Leader>gp "+gp
vmap <Leader>gP "+gP
" PRIMARY
" いい感じのkeymapを思いつくまで保留
vmap [wLeader]y "*y
vmap [wLeader]d "*d
nmap [wLeader]p "*p
nmap [wLeader]P "*P
vmap [wLeader]p "*p
vmap [wLeader]P "*P
nmap [wLeader]gp "*gp
nmap [wLeader]gP "*gP
vmap [wLeader]gp "*gp
vmap [wLeader]gP "*gP

" <Space><Space>vでビジュアルラインモードに切り替える
nmap [wLeader]v V

