# if running bash
# if [ -n "$BASH_VERSION" ]; then
#   # include .bashrc if it exists
#   if [ -f ~/.bashrc ]; then
#     . ~/.bashrc
#   fi
# fi
export PATH="$HOME/bin:$HOME/.bin:$HOME/.local:$HOME/.local/bin/:$PATH"
if [ -f ~/todo ]; then
    cat ~/todo
fi
