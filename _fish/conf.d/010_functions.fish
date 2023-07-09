function cd-ghq
    set selected_dir (ghq list -p | peco)
    if test -n "$selected_dir"
        cd $selected_dir
        commandline -f repaint
    end
    clear
end

bind \cg cd-ghq
