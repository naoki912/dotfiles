"  " The prefix key.
"  nnoremap [sTag] <Nop>
"  nmap     s      [sTag]
"
"  " ss 通常のs
"  nnoremap <silent> [sTag]s s
"
"  "--
"  " Window
"  "--
"
"  " s- Windowを上下分割
"  nnoremap <silent> [sTag]- :split<CR>
"
"  " s| Windowを左右分割
"  nnoremap <silent> [sTag]<Bar> :vsplit<CR>
"
"  " sx タブを閉じる
"  nnoremap <silent> [sTag]x :close<CR>
"
"  " sw 次のwindowに移動
"  nnoremap <silent> [sTag]w     <C-w>w
"  nnoremap <silent> [sTag]<C-w> <C-w><C-w>
"  " sW 逆回転
"  nnoremap <silent> [sTag]W     <C-w>W
"  " sp 一つ前のwindowに戻る
"  " コンフリクト
"  " TODO: pとwを逆にしても良いかも (p <C-w>w, w <C-w>p)
"  "nnoremap <silent> [sTag]<BS>  <C-w>p
"
"  " s hjkl 別Windowにカーソルを移動
"  nnoremap <silent> [sTag]h <C-w>h
"  nnoremap <silent> [sTag]j <C-w>j
"  nnoremap <silent> [sTag]k <C-w>k
"  nnoremap <silent> [sTag]l <C-w>l
"
"  " w HJKL Windowの位置を移動 (TODO: tmuxに合わせてサイズ変更のほうが良いかも？)
"  nnoremap <silent> [sTag]H <C-w>H
"  nnoremap <silent> [sTag]J <C-w>J
"  nnoremap <silent> [sTag]K <C-w>K
"  nnoremap <silent> [sTag]L <C-w>L
"  " window回転
"  nnoremap <silent> [sTag]r <C-w>r
"  nnoremap <silent> [sTag]R <C-w>R
"
"  " Windowサイズ変更
"  " TODO: 連続で押せるようにする
"  " increase current window height N lines
"  nnoremap <silent> [sTag]+ <C-w>+
"  " decrease current window height N lines
"  " コンフリクト
"  "nnoremap <silent> [sTag]- <C-w>-
"  " increase current window width N columns
"  nnoremap <silent> [sTag]> <C-w>>
"  " decrease current window width N columns
"  nnoremap <silent> [sTag]< <C-w><
"  " make all windows the same height & width
"  nnoremap <silent> [sTag]= <C-w>=
"
"  " windowの最大化, 最小化
"  "nnoremap so <C-w>_<C-w>|
"  "nnoremap sO <C-w>=
"
"  "--
"  " Tab
"  "--
"
"  " Tab jump
"  " t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
"  for n in range(1, 9)
"      execute 'nnoremap <silent> [sTag]'.n  ':<C-u>tabnext'.n.'<CR>'
"  endfor
"
"  " sc 新しいタブを一番右に作る
"  nnoremap <silent> [sTag]c :tablast <bar> tabnew<CR>
"
"  " sx タブを閉じる
"  nnoremap <silent> [sTag]x :tabclose<CR>
"
"  " sn, sp 次のタブ
"  nnoremap <silent> [sTag]n :tabnext<CR>
"  nnoremap <silent> [sTag]p :tabprevious<CR>
"
