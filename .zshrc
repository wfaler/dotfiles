export ZSH=/usr/share/oh-my-zsh/
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
alias vi=nvim
alias vim=nvim
source ~/.envrc

export PYTHON_PATH=".local/share/mise/installs/python/3.12/bin"
export PATH=$PYTHON_PATH:/home/wfaler/.local/share/mise/shims:$PATH
eval "$(direnv hook zsh)"
