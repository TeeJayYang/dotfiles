export PATH="$HOME/bin:$HOME/.bin:$HOME/.local:$HOME/.local/bin/:$PATH"
export TERMINAL="urxvt"
source ~/.git-completion.bash

alias l='ls -B --color=auto'
alias ls='ls --color=auto'
alias rm='rm -i'
alias python='python3'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[38;5;245m\]\w\[\033[33m\]\$(parse_git_branch) \[\e[0m\] \n "
if [ -n "$SSH_CLIENT" ]; then
  export PS1="(ssh) $PS1"
fi

function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}
alias r='ranger-cd'
alias ranger='ranger-cd'
alias spython='~/Downloads/splunk/bin/python'

export VISUAL=vim
export EDITOR="$VISUAL"
set -o vi

[[ -f ~/.Xresources ]] && xrdb ~/.Xresources
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash
[ -f /usr/share/bash-completion/completions/git ] && source /usr/share/bash-completion/completions/git
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth

export SOLN_ROOT="~/"
export SPLUNK_HOME="/home/tyang/Downloads/splunk"
export SPLUNK_DB="$SPLUNK_HOME/var/lib/splunk"
export SPLUNK_ETC="$SPLUNK_HOME/etc"
export SPLUNKD_URI="https://localhost:8089"
export HOSTNAME=`hostname`
export APPS_ROOT="$SPLUNK_ETC"
alias splunk="$SPLUNK_HOME/bin/splunk"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias orca='splunk_orca'
export BAT_THEME="TwoDark"
