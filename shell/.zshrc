#############################
# ZINIT & Plugin Manager Setup
#############################

# Connect to tmux
if [ "$TMUX" = "" ]; then
  tmux attach -t main >/dev/null 2>&1 || tmux new -s main
  exit
fi

# Evaluate direnv if installed
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

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

# Initialize zoxide if installed
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi

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

#############################
# Packages Configuration
#############################

# Add Cargo bin to PATH if directory exists
if [ -d ~/.cargo/bin ]; then
  export PATH=$PATH:~/.cargo/bin/
fi

# Source OPAM init if available
[[ ! -r '/home/rami/.opam/opam-init/init.zsh' ]] || source '/home/rami/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null

#############################
# Powerlevel10k Prompt Configuration
#############################

# Source Powerlevel10k configuration
if [[ -f "$HOME/.p10k.zsh" ]]; then
  source "$HOME/.p10k.zsh"
fi
