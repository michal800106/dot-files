function fish_prompt
	and set retc green; or set retc red
    tty|string match -q -r tty; and set tty tty; or set tty pts

    set_color $retc
    if [ $tty = tty ]
        echo -n .-
    else
        echo -n '┬─'
    end
    set_color -o green
    echo -n [
    if set --query GTOOL_ENV
       set_color -o black
       echo -n $GTOOL_ENV:
    end
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

    set -l hg_branch_curr (hg log -r "last(branch(''))" --template ' | {rev}:{node|short}' 2>&-)
    if [ $status -eq 0 ]
        set -l hg_branch_name (hg branch)
        set -l hg_path (hg paths | head)
        set -l hg_project (basename $hg_path)
        set -l hg_changeset (hg log -r "p1()+p2()" | grep changeset | perl -ne 's{^.*changeset:}{}; s{^\s+|\s+$}{}g; print')
        set -l hg_branch_parent (hg log -r "first(p1(branch('')))" --template '{branch} | {rev}:{node|short}')
        if [ -z $hg_branch_parent ]
            set hg_branch_parent "default"
        end
        set_color normal
        set_color blue
        echo -n ' ['
        set_color  red
        echo -n $hg_project
        set_color normal
        set_color blue
        echo -n ':-> '
        set_color normal
        set_color blue
        echo -n ' ('
        set_color red
        echo -n $hg_branch_parent
        set_color normal
        set_color blue
        echo -n ' --> '
        set_color -o 02f
        echo -n "$hg_branch_name""$hg_branch_curr"
        set_color normal
        set_color blue
        echo -n ')]'
    end
    
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
    set_color $retc
    if [ $tty = tty ]
        echo -n "'->"
    else
        echo -n '╰─>'
    end
    set_color -o red
    echo -n '$ '
    set_color normal
end
