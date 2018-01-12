#source /usr/share/defaults/etc/profile
export PATH="$HOME/bin:$HOME/.bin:$HOME/.local:$PATH"

alias l='ls -B --color=auto'
alias ls='ls --color=auto'
alias rm='rm -i'
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[38;5;081m\]\u\[\033[38;5;245m\]@\[\033[38;5;206m\]\H \[\033[38;5;245m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[38;5;081m\] \n$ \[\e[0m\]"

function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}
alias ranger='ranger-cd'
