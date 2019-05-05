alias h-vim-split='\cat << EOF
" :h CTRL-W

|<C-W>s|    :split
|<C-W>v|    :vsplit
|<C-W>o|    :only
|<C-W>c|    :close
|<C-W>q|    :quit
# ":close": close current window, unless it is the last one
# ":quit": quit current window, quit Vim if the last window is closed.

|<C-W>w|    次のwindowに移動
|<C-W>W|    前のwindowに移動
|<C-W>h|    左のwindowに移動
|<C-W>j|    下のwindowに移動
|<C-W>k|    上のwindowに移動
|<C-W>l|    右のwindowに移動
|<C-W>b|    一番下のwindowに移動
|<C-W>t|    一番上のwindowに移動
|<C-W>p|    直前(最後にアクセスしていた)の window に移動する

|<C-W>H|    current window を 一番左に移動する
|<C-W>J|    current window を 一番下に移動する
|<C-W>K|    current window を 一番上に移動する
|<C-W>L|    current window を 一番右に移動する
|<C-W>T|    current window を 新しいタブページに移動する

|<C-W>+|    current window の 高さを 増やす
|<C-W>-|    current window の 高さを 減らす
|<C-W>_|    current window の 高さを 最大にする
|<C-W>>|    current window の 幅を   増やす
|<C-W><|    current window の 幅を   減らす
|<C-W>||    current window の 幅を   最大にする
|<C-W>=|    全ての window の高さと幅を揃える

|<C-W>r|    window を下方向に回転させる
|<C-W>R|    window を上方向に回転させる

|<C-W>n|    新しいバッファを作成してスプリット

|<C-W>x|    exchange current window with window N (default: next window)
EOF
'
