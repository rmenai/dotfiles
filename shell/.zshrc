#############################
# ZINIT & Plugin Manager Setup
#############################

# Connect to tmux
if [ "$TMUX" = "" ]; then
  tmux attach -t main >/dev/null 2>&1 || tmux new -s main
  exit
fi

# Evaluate direnv
eval "$(direnv hook zsh)"

# Define where to install Zinit
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Clone Zinit if not already installed
if [ ! -d "$ZINIT_HOME" ] || [ ! -d "$ZINIT_HOME/.git" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source Zinit
source "${ZINIT_HOME}/zinit.zsh"

#############################
# Early Prompt Setup: Powerlevel10k Instant Prompt
#############################

# Enable Powerlevel10k instant prompt for a faster startup
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#############################
# Load Environment & Custom Scripts
#############################

# Source .profile if not already loaded
if [[ -f "$HOME/.profile" ]]; then
  source "$HOME/.profile"
fi

# Load custom configuration files
source "$HOME/.config/zsh/catppuccin_mocha-fzf.zsh"

# Initialize zoxide (for directory jumping)
eval "$(zoxide init --cmd cd zsh)"

#############################
# Zsh Plugin Settings
#############################

# Customize plugin settings before loading
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
ZVM_CURSOR_STYLE_ENABLED=true

#############################
# Plugin Installation & Turbo Loading
#############################

# Load plugins concurrently using Zinit's "for" syntax.
# Use light-mode for faster startup. Adjust lazy-loading (e.g. using 'wait' or 'defer') if you have plugins that aren’t needed immediately.
zinit for \
  light-mode \
    jeffreytse/zsh-vi-mode \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-completions \
    romkatv/powerlevel10k

# Load zsh-fsh catpuccin theme
fast-theme XDG:catppuccin-mocha > /dev/null 2>&1

# Load nixos specific config
if [ -f /etc/NIXOS ]; then
  any-nix-shell zsh --info-right | source /dev/stdin

#############################
# Packages Configuration
#############################

export PATH=$PATH:~/.cargo/bin/

[[ ! -r '/home/rami/.opam/opam-init/init.zsh' ]] || source '/home/rami/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
fi

#############################
# Powerlevel10k Prompt Configuration
#############################

if [[ -f "$HOME/.p10k.zsh" ]]; then
  source "$HOME/.p10k.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit /persist/home/rami/.p10k.zsh.
[[ ! -f /persist/home/rami/.p10k.zsh ]] || source /persist/home/rami/.p10k.zsh
