" split系
" :h CTRL-W

" The prefix key.
"nnoremap    [WindowTag]   <Nop>
"nmap        w       [WindowTag]
"nmap        <C-w>   [WindowTag]

" w- Windowを上下分割
nnoremap <C-w>-     :split<CR>

" w| Windowを左右分割
nnoremap <C-w><Bar> :vsplit<CR>

" wx タブを閉じる
nnoremap <C-w>x     :close<CR>

" wc を無効化
nnoremap <C-w>c     <Nop>

" wo, wO 移動
nnoremap <C-w>o     <C-w>w
nnoremap <C-w>O     <C-w>W
nnoremap <C-w><BS>  <C-w>p

