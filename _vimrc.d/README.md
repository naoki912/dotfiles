# vimrc.d

## Tag？について

下の形で `<C-w>` などに名前を付けたりすると、元々存在しているキーバインドまでまとめて上書きされてしまう。  
元々あるキーバインドも明示的に再定義しなくちゃならなくなるので `<leader>` 系でしか使わないようにすること。

```vim
nnoremap    [WindowTag]   <Nop>
nmap        <C-w>   [WindowTag]

nnoremap <silent> [WindowTag]w      <C-w>w
nnoremap <silent> [WindowTag]<C-w>  <C-w><C-w>
```

