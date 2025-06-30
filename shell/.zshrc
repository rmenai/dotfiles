#############################
# Load Environment & Custom Scripts
#############################

# Load custom configuration files
source "$HOME/.config/zsh/catppuccin_mocha-fzf.zsh"

eval "$(gh copilot alias -- zsh)"

# Initialize zoxide if installed
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi

# Evaluate direnv if installed
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

#############################
# ZINIT & Plugin Manager Setup
#############################

# Source .profile if not already loaded
if [[ -f "$HOME/.profile" ]]; then
  source "$HOME/.profile"
fi

# Define where to install Zplug
export ZPLUG_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zplug"

# Clone Zplug if not already installed
if [ ! -d "$ZPLUG_HOME" ] || [ ! -d "$ZPLUG_HOME/.git" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
fi

# Source Zinit
source "${ZPLUG_HOME}/init.zsh"

#############################
# Early Prompt Setup: Powerlevel10k Instant Prompt
#############################

# Enable Powerlevel10k instant prompt for a faster startup
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
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

export HISTORY_BASE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/history"
export HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/.histfile"

zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "jeffreytse/zsh-vi-mode"
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma-continuum/fast-syntax-highlighting", defer:2
zplug "~/.zfunc", from:local, as:plugin, use:"*"
zplug "zsh-users/zsh-completions"
zplug "jimhester/per-directory-history"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Load zsh-fsh catpuccin theme
if command -v fast-theme &> /dev/null; then
  fast-theme XDG:catppuccin-mocha > /dev/null 2>&1
else
  echo "Warning: fast-theme command not available yet or plugin not fully loaded." >&2
fi

#############################
# Packages Configuration
#############################

# Add Cargo bin to PATH if directory exists
if [ -d ~/.cargo/bin ]; then
  export PATH=$PATH:~/.cargo/bin/
fi

# Source OPAM init if available
[[ ! -r '~/.opam/opam-init/init.zsh' ]] || source '~/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null

#############################
# Powerlevel10k Prompt Configuration
#############################

# Source Powerlevel10k configuration
if [[ -f "$HOME/.p10k.zsh" ]]; then
  source "$HOME/.p10k.zsh"
fi
