function is_exists
    type -q "$argv[1]"
    return $status
end

function is_osx
    test (uname) = "Darwin"
end

function is_screen_running
    test -n "$STY"
end

function is_tmux_running
    test -n "$TMUX"
end

function is_screen_or_tmux_running
    is_screen_running; or is_tmux_running
end

function shell_has_started_interactively
    status is-interactive
end

function is_ssh_running
    test -n "$SSH_CONNECTION"
end

function tmux_automatically_attach_session
    # vscodeの時はtmuxを起動しない
    if test "$TERM_PROGRAM" = "vscode"
        return
    end

    if is_screen_or_tmux_running
        if not is_exists 'tmux'
            return 1
        end
    else if shell_has_started_interactively; and not is_ssh_running
        if not is_exists 'tmux'
            echo 'Error: tmux command not found' >&2
            return 1
        end

        if tmux has-session >/dev/null ^&1; and tmux list-sessions | grep -qE '.*]$'
            # detached session exists
            tmux list-sessions
            echo -n "Tmux: attach? (y/N/num) "
            read -l REPLY
            switch "$REPLY"
                case '' '[Yy]'
                    tmux attach-session
                    if test $status -eq 0
                        echo (tmux -V)" attached session"
                        return 0
                    end
                case '*[0-9]*'
                    tmux attach -t "$REPLY"
                    if test $status -eq 0
                        echo (tmux -V)" attached session"
                        return 0
                    end
            end
        end

        if is_osx; and is_exists 'reattach-to-user-namespace'
            # on OS X force tmux's default command
            # to spawn a shell in the user's namespace
            set tmux_config (cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
            tmux -f (echo "$tmux_config") new-session; and echo (tmux -V)" created new session supported OS X"
        else
            tmux new-session; and echo "tmux created new session"
        end
    end
end

tmux_automatically_attach_session
