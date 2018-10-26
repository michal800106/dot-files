function fish_prompt
	and set retc green; or set retc red
    tty|string match -q -r tty; and set tty tty; or set tty pts

    set -g __fish_git_prompt_showuntrackedfiles yes
    set -g __fish_git_prompt_showstashstate yes
    set -g __fish_git_prompt_showdirtystate yes
    set -g __fish_git_prompt_showupstream auto verbose name git
    set -g __fish_git_prompt_describe_style describe
    set -g __fish_git_prompt_show_informative_status yes

    # set_color $retc
    # if [ $tty = tty ]
    #     echo -n .-
    # else
    #     echo -n '┬─'
    # end
    set_color -o green
    echo -n [
    if test $USER = root -o $USER = toor
        set_color -o red
    else
        set_color -o 190
    end
    echo -n $USER
    set_color -o white
    echo -n @
    if [ -z "$SSH_CLIENT" ]
        set_color -o blue
    else
        set_color -o 02f
    end
    echo -n (hostname)
    set_color normal
    #echo -n :(prompt_pwd)
    echo -n :(pwd|sed "s=$HOME=~=")
    set_color -o green
    echo -n ']'
    set_color normal
    set_color $retc
    if [ $tty = tty ]
        echo -n '-'
    else
        echo -n '─'
    end
    set_color -o green
    echo -n '['
    set_color normal
    set_color $retc
    echo -n (date +%X)
    set_color -o green
    echo -n ]

    __fish_git_prompt

    if type -q acpi
		if [ (acpi -a 2> /dev/null | string match -r off) ]
			echo -n '─['
			set_color -o red
			echo -n (acpi -b|cut -d' ' -f 4-)
			set_color -o green
			echo -n ']'
		end
	end
    echo
    set_color normal
    for job in (jobs)
        set_color $retc
        if [ $tty = tty ]
            echo -n '; '
        else
            echo -n '│ '
        end
        set_color brown
        echo $job
    end
    set_color normal
    # set_color $retc
    # if [ $tty = tty ]
    #     echo -n "'->"
    # else
    #     echo -n '╰─>'
    # end
    set_color -o $retc 
    echo -n '$$## '
    set_color normal
end
