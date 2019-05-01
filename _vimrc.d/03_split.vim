" The prefix key.
nnoremap    [WindowTag]   <Nop>
"nmap        w       [WindowTag]
nmap        <C-w>   [WindowTag]

" w- Windowを上下分割
nnoremap <silent> [WindowTag]- :split<CR>
" w| Windowを左右分割
nnoremap <silent> [WindowTag]<Bar> :vsplit<CR>

" wx タブを閉じる
nnoremap <silent> [WindowTag]x :close<CR>

" ww 次のwindowに移動
nnoremap <silent> [WindowTag]w <C-w>w
nnoremap <silent> [WindowTag]<C-w> <C-w><C-w>

" w hjkl 別Windowにカーソルを移動
nnoremap <silent> [WindowTag]h <C-w>h
nnoremap <silent> [WindowTag]j <C-w>j
nnoremap <silent> [WindowTag]k <C-w>k
nnoremap <silent> [WindowTag]l <C-w>l

" w HJKL Windowの位置を移動 (TODO: tmuxに合わせてサイズ変更のほうが良いかも)
nnoremap <silent> [WindowTag]H <C-w>h
nnoremap <silent> [WindowTag]J <C-w>j
nnoremap <silent> [WindowTag]K <C-w>k
nnoremap <silent> [WindowTag]L <C-w>l

" Windowサイズを変更
" TODO: 連続で押せるようにする

"--------------------
" tn, tl 次のタブ
" map <silent> [WindowTag]n :tabnext<CR>
" map <silent> [WindowTag]l :tabnext<CR>

" tp, th 前のタブ
" map <silent> [WindowTag]p :tabprevious<CR>
" map <silent> [WindowTag]h :tabprevious<CR>

" tc 新しいタブを一番右に作る
" map <silent> [Tag]c :tablast <bar> tabnew<CR>
"map <silent> [Tag]n :tablast <bar> tabnew<CR>

" tx タブを閉じる
" map <silent> [Tag]x :tabclose<CR>

" tn, tl 次のタブ
" map <silent> [Tag]n :tabnext<CR>
" map <silent> [Tag]l :tabnext<CR>

" tp, th 前のタブ
" map <silent> [Tag]p :tabprevious<CR>
" map <silent> [Tag]h :tabprevious<CR>

