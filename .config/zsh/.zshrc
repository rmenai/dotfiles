# Profile
source $HOME/.profile

export ZSH_DIR="$HOME/.config/zsh"
export ZSH="$ZSH_DIR/.oh-my-zsh"

ZSH_THEME=""

plugins=(git zsh-vi-mode dirhistory autoswitch_virtualenv zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

eval "$(oh-my-posh init zsh --config $ZSH_DIR/themes/catppuccin_mocha.omp.json)"
