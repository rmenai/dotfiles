# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Install zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Install plugins
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# Plugin settings
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
ZVM_CURSOR_STYLE_ENABLED=false

# Install theme
zinit ice depth"1"
zinit light romkatv/powerlevel10k

# Settings
alias ls="exa"
alias cd="z"
export EDITOR="nvim" SUDO_EDITOR="nvim"
export HISTFILE="$HOME/.histfile" HISTSIZE=1000 SAVEHIST=1000
setopt SHARE_HISTORY

# WSL paths
if grep -qi microsoft /proc/version; then
  export BROWSER=wslview
  export PATH=$PATH:/mnt/c/Programs/Path:/mnt/c/Programs/Sioyek
fi

# fzf theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

# Initialize zsh plugins
eval "$(zoxide init zsh)"

# Powerlevel10k prompt configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
