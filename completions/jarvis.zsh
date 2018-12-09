#compdef jarvis

# This completion file should be linked to a directory in ZSH fpath
# and named `_sub`.

case $CURRENT in
    2)
        local cmds
        local -a commands
        cmds=$(jarvis commands)
        commands=(${(ps:\n:)cmds})
        _wanted command expl "jarvis command" compadd -a commands
        ;;
    *)
        local cmd subcmds
        local -a commands
        cmd=${words[2]}
        subcmds=$(jarvis completions ${words[2,$(($CURRENT - 1))]})
        commands=(${(ps: :)subcmds})
        _wanted subcommand expl "jarvis $cmd subcommand" compadd -a commands
        ;;
esac
