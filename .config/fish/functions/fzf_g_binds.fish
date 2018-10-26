function fzf_g_binds
    function is_in_git_repo
      git rev-parse HEAD > /dev/null 2>&1
    end
    
    function gf
      is_in_git_repo; and git -c color.status=always status --short | fzf --height 40% -m --ansi --nth 2..,.. -e | awk '{print $2}'
    end
    
    function gb
      is_in_git_repo; and git branch -a -vv --color=always | grep -v '/HEAD\s' | fzf --height 40% --ansi --multi -e | sed 's/^..//' | awk '{print $1}' | sed 's#^remotes/[^/]*/##'
    end
    
    function gt
      is_in_git_repo; and git tag --sort -version:refname | fzf --height 40% --multi -e
    end
    
    function gh
      is_in_git_repo; and git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" | fzf --height 40% --ansi --no-sort --multi -e | awk '{print $2}'
    end
    
    function gr
      is_in_git_repo; and git remote -v | awk '{print $1 " " $2}' | uniq | fzf --height 40% -e | awk '{print $1}'
    end
    
    function choose_what_g
        echo "choose action:
        gf - status
        gb - branch
        gt - tags
        gh - logs
        gr - remote
"
    
        read action
    
        switch $action
            case 'gf'
                gf
            case 'gb'
                gb
            case 'gt'
                gt
            case 'gh'
                gh
            case 'gr'
                gr
        end
    end

    bind \eg choose_what_g

    if bind -M insert > /dev/null 2>&1
        bind -M insert \eg choose_what_g
    end
end
