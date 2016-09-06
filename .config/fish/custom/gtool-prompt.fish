function gtool-prompt-off
    if set --query GTOOL_ENV
        set -xg PATH $GTOOL_PATH_BAK
        set --erase GTOOL_ENV
        set --erase GTOOL_ENVPATH
        # set --erase PYTHONSTARTUP
	functions --erase grep
    end 
end

function gtool-prompt --on-event fish_prompt
    set --local ABSPATH (readlink -f "$PWD")
    if not set --query GTOOL_BASEDIR
       set GTOOL_BASEDIR "/srv/websites/"
    end

    set --local abspath (string sub -s 1 -l 14 "$ABSPATH")
    if string match -aq "$abspath" "$GTOOL_BASEDIR"
        set --local DIRLIST ( string split '/' $ABSPATH )
        if [ x"$GTOOL_ENV" != x"$DIRLIST[4]" ]
            gtool-prompt-off
            if [ -d "$GTOOL_BASEDIR""$DIRLIST[4]/bin" ]
                set -xg GTOOL_ENV "$DIRLIST[4]"
                set -xg GTOOL_ENVPATH $GTOOL_BASEDIR/$DIRLIST[4]
                #set --export PYTHONSTARTUP "$GTOOL_ENVPATH/bin/bpythonrc.py"

                set -xg GTOOL_PATH_BAK $PATH
                set -xg PATH "$GTOOL_BASEDIR""$GTOOL_ENV""/bin" $PATH

                #echo "Activating [""$GTOOL_ENV""]"
		alias grep='grep --exclude-dir=.hg --exclude-dir=.git --exclude-dir=.svn'
            end
        end
    else
        gtool-prompt-off
    end
end
