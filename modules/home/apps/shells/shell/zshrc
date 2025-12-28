# .zshrc - Zsh-specific configuration

#############################
# Load Environment & Profile
#############################

# Source .profile for environment variables (if not already loaded in login shell)
if [[ -f "$HOME/.profile" ]]; then
  source "$HOME/.profile"
fi

# Source .bashrc if it exists (for compatibility)
if [[ -f "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
fi

#############################
# Zsh-specific Settings
#############################

# History configuration (Zsh-specific)
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/.histfile"
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt EXTENDED_HISTORY

# Other useful Zsh options
setopt AUTO_CD
setopt CORRECT
setopt COMPLETE_ALIASES

#############################
# Early Prompt Setup: Powerlevel10k Instant Prompt
#############################

# Enable Powerlevel10k instant prompt for a faster startup
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#############################
# Plugin Manager Setup (Zplug)
#############################

# Define where to install Zplug
export ZPLUG_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zplug"

# Clone Zplug if not already installed
if [ ! -d "$ZPLUG_HOME" ] || [ ! -d "$ZPLUG_HOME/.git" ]; then
  mkdir -p "$(dirname "$ZPLUG_HOME")"
  git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
fi

# Source Zplug
source "${ZPLUG_HOME}/init.zsh"

#############################
# Zsh Plugin Settings
#############################

# Customize plugin settings before loading
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
ZVM_CURSOR_STYLE_ENABLED=true

#############################
# Plugin Installation & Loading
#############################

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

#############################
# External Tool Initialization
#############################

# Load custom configuration files
if [[ -f "$HOME/.config/zsh/catppuccin_mocha-fzf.zsh" ]]; then
  source "$HOME/.config/zsh/catppuccin_mocha-fzf.zsh"
fi

# Initialize external tools
if command -v gh &> /dev/null; then
  eval "$(gh copilot alias -- zsh)"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi

if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

if command -v fnm &> /dev/null; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

# Source OPAM init if available
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null

#############################
# Theme Configuration
#############################

# Load zsh-fsh catpuccin theme
if command -v fast-theme &> /dev/null; then
  fast-theme XDG:catppuccin-mocha > /dev/null 2>&1
fi

# Source Powerlevel10k configuration
if [[ -f "$HOME/.p10k.zsh" ]]; then
  source "$HOME/.p10k.zsh"
fi

#############################
# Aliases
#############################

# NixOS aliases
alias nix-shell="nix-shell --run zsh"
alias nrs="sudo nixos-rebuild switch --flake $(realpath ~/.config/nixos)#$(hostname)"
alias nrb="sudo nixos-rebuild boot --flake $(realpath ~/.config/nixos)#$(hostname)"
alias nrt="sudo nixos-rebuild test --flake $(realpath ~/.config/nixos)#$(hostname)"

alias hrs="home-manager switch --flake $(realpath ~/.config/nixos)#vault@$(hostname)"
alias hrb="home-manager build --flake $(realpath ~/.config/nixos)#vault@$(hostname)"

# System aliases
alias hibernate="systemctl hibernate"
alias rm="rm -I"

# Navigation aliases
alias z="cdi"
alias ll="ls -alF"
alias la="ls -A"

# Tool-dependent aliases
if command -v bat &> /dev/null; then
  alias cat="bat"
  alias -g -- -h="-h 2>&1 | bat --language=help --style=plain"
  alias -g -- --help="--help 2>&1 | bat --language=help --style=plain"
fi

if command -v exa &> /dev/null; then
  alias ls="exa"
fi

# Combined tool aliases
if command -v fzf &> /dev/null && command -v bat &> /dev/null; then
  alias fzfp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
fi

# Clipboard aliases (X11)
if command -v xclip &> /dev/null; then
  alias c="xclip -sel c"
  alias p="xclip -sel c -o"
  alias cs="xclip"
  alias vs="xclip -o"
fi

# Editor aliases
if command -v nvim &> /dev/null; then
  alias v="nvim"
  alias vimdiff="nvim -d"
fi

# Tmux aliases
if command -v tmux &> /dev/null; then
  alias t="tmux"
  alias ta="tmux attach"
  alias tad="tmux attach -d -t"
  alias tkss="tmux kill-session -t"
  alias tksv="tmux kill-server"
  alias tl="tmux list-sessions"
  alias ts="tmux new-session -s"
fi

# GitHub Copilot aliases
if command -v ghcs &> /dev/null; then
  alias \?="ghcs"
  alias \?\?="ghce"
fi

#############################
# Functions
#############################

# Yazi file manager with directory changing
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ "$cwd" != "" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Sesh session manager
function s() {
  exec </dev/tty
  exec <&1
  local session
  session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
  zle reset-prompt >/dev/null 2>&1 || true
  [[ -z "$session" ]] && return
  sesh connect "$session"
}

# Wezterm nvim function
function wtnvim() {
  if [ "$1" = "" ]; then
    echo "Usage: wtnvim <file>"
    return 1
  fi

  wezterm cli spawn -- zsh -l -i -c "
    cd \"$(dirname "$1")\" && \
    nvim \"$(realpath "$1")\"; \
    exec zsh"
}

# Create history directory if it doesn't exist
[[ ! -d "${HISTFILE:h}" ]] && mkdir -p "${HISTFILE:h}"
