map <Space> <Nop>
let mapleader = "\<Space>"

" http://postd.cc/how-to-boost-your-vim-productivity/

" <Space>wを押してファイルを保存する（:w<Enter>よりずっと速い）
nnoremap <Leader>w :w<CR>


"--
" コピー系
"--

" [wLeader] に<Leader><Leader>を割り当て
" `<Leader><Leader>と2回入力 == [wLeader]`
nnoremap [wLeader] <Nop>
nmap <Leader><Leader> [wLeader]

" <Space>pと<Space>yでシステムのクリップボードにコピー＆ペーストする
" CLIPBOARD, PRIMARYの違い https://oplern.hatenablog.com/entry/2017/04/10/070433
" CLIPBOARD
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
"nmap <Leader>gp "+gp
"nmap <Leader>gP "+gP
"vmap <Leader>gp "+gp
"vmap <Leader>gP "+gP
" PRIMARY
" いい感じのkeymapを思いつくまで保留
vmap [wLeader]y "*y
vmap [wLeader]d "*d
nmap [wLeader]p "*p
nmap [wLeader]P "*P
vmap [wLeader]p "*p
vmap [wLeader]P "*P
"nmap [wLeader]gp "*gp
"nmap [wLeader]gP "*gP
"vmap [wLeader]gp "*gp
"vmap [wLeader]gP "*gP

" <Space><Space>vでビジュアルラインモードに切り替える
nmap [wLeader]v V


"--
" Cursor
"--

"nnoremap <Leader>h  ^
"nnoremap <Leader>l  $
nnoremap <Leader>/  *
nnoremap <Leader>m  %
nnoremap <Leader>0  $


"--
" Window
"--

" Windowを上下分割
nnoremap <silent> <Leader>- :split<CR>
" Windowを左右分割
nnoremap <silent> <Leader><Bar> :vsplit<CR>
" タブを閉じる
nnoremap <silent> <Leader>x :close<CR>

" 次のwindowに移動
nnoremap <silent> <Leader>o <C-w>w
" 前のwindowに移動
nnoremap <silent> [wLeader]o <C-w>W
" 1つ前のActive windowに移動
nnoremap <silent> <Leader><BS> <C-w>p

nnoremap <silent> <Leader>h <C-w>h
nnoremap <silent> <Leader>j <C-w>j
nnoremap <silent> <Leader>k <C-w>k
nnoremap <silent> <Leader>l <C-w>l

" w HJKL Windowの位置を移動 (TODO: tmuxに合わせてサイズ変更のほうが良いかも？)
nnoremap <silent> <Leader>H <C-w>H
nnoremap <silent> <Leader>J <C-w>J
nnoremap <silent> <Leader>K <C-w>K
nnoremap <silent> <Leader>L <C-w>L

" window回転
nnoremap <silent> <Leader>O <C-w>r
nnoremap <silent> [wLeader]O <C-w>R

" Windowサイズ変更
" TODO: 連続で押せるようにする
" increase current window height N lines
nnoremap <silent> <Leader>+ <C-w>+
" decrease current window height N lines
" コンフリクト
"nnoremap <silent> [sTag]- <C-w>-
nnoremap <silent> [wLeader]- <C-w>-
" increase current window width N columns
nnoremap <silent> <Leader>> <C-w>>
" decrease current window width N columns
nnoremap <silent> <Leader>< <C-w><
" make all windows the same height & width
nnoremap <silent> <Leader>= <C-w>=
" windowの最大化
nnoremap <silent> [wLeader]= <C-w>_<C-w>|


"--
" Tab
"--

" Tab jump
" <Leader>1 で1番左のタブ、<Leader>2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
    execute 'nnoremap <silent> <Leader>'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" 新しいタブを1番右に作る
nnoremap <silent> <Leader>c :tablast <bar> tabnew<CR>
" タブを閉じる(複数windowがあった場合も全て閉じる)
nnoremap <silent> [wLeader]x :tabclose<CR>

" sn, sp 次のタブ
nnoremap <silent> <Leader>] :tabnext<CR>
nnoremap <silent> <Leader>[ :tabprevious<CR>

