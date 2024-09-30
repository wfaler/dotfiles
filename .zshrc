export ZSH=/usr/share/oh-my-zsh/
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
alias vi=nvim
alias vim=nvim


export PATH=/home/wfaler/.local/share/mise/shims:$PATH
eval "$(direnv hook zsh)"
