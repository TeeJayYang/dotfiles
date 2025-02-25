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
alias ag='ag --pager="less -XFR"'

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
export HISTCONTROL=ignoreboth:erasedups

export SOLN_ROOT="$HOME/"
export SPLUNK_HOME="/home/tyang/Downloads/splunk"
export SPLUNK_DB="$SPLUNK_HOME/var/lib/splunk"
export SPLUNK_ETC="$SPLUNK_HOME/etc"
export SPLUNKD_URI="https://localhost:8089/"
export SPLUNKD="$SPLUNKD_URI"
export SPLUNKADMINUSERNAME="admin"
export SPLUNKPASSWORD="changeme"
alias spython="/home/tyang/Downloads/splunk/bin/python3"
# export SPLUNK_SOURCE="~/main"
# export UI_SOURCE="~/splunkcore-web-ui"
export SPLUNK_SOURCE="/home/tyang/splunkcore-web-ui"
export HOSTNAME=`hostname`
export APPS_ROOT="$SPLUNK_ETC"
alias splunk="$SPLUNK_HOME/bin/splunk"
alias ess="cd $SOLN_ROOT/app-ess/packages/app-ess"
alias blue="cd $HOME/blueridge-app/packages/ui"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias orca='splunk_orca'
alias kset='xset r rate 200 50'
export BAT_THEME="TwoDark"
if [ -f ~/todo ]; then
    cat ~/todo
fi
alias gp='globalprotect connect --gateway sjc1-gw4.splunk.com -u tyang'
alias gp2='globalprotect connect --gateway sfo1-gw4.splunk.com -u tyang'
