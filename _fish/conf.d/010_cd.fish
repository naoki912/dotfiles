# cd 無しでディレクトリ移動出来るようにするやつ
# zshrc から持ってきた
function chpwd
  ls_abbrev
end

function ls_abbrev
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    set cmd_ls 'ls'
    set opt_ls '-CF' '--color=always'
    switch (uname)
        case 'FreeBSD' 'Darwin'
            if type -q gls
                set cmd_ls 'gls'
            else
                # -G : Enable colorized output.
                set opt_ls '-aCFG'
            end
    end

    set -l ls_result
    set ls_result (env CLICOLOR_FORCE=1 COLUMNS=$COLUMNS $cmd_ls $opt_ls | sed '/^\e\[[0-9;]*m$/d')

    set -l ls_lines
    set ls_lines (echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 35 ]
        echo "$ls_result" | head -n 18
        echo '...'
        echo "$ls_result" | tail -n 18
        echo (ls -1 -A | wc -l | tr -d ' ') "files exist"
    else
        echo "$ls_result"
    end
end

set -U fish_user_paths .. $HOME $fish_user_paths
cd
