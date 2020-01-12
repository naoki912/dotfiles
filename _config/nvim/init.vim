" https://stackoverflow.com/questions/4500748/how-to-source-all-vim-files-in-directory
for f in split(glob('~/.vimrc.d/*.vim'), '\n')
    exe 'source' f
endfor
