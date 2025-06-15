# Bash config
if [ "$BASH_VERSION" != "" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# Home-manager config
if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

# Nix config
if [ -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
  . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi

# WSL config
if grep -qi microsoft /proc/version; then
  export BROWSER=wslview
  export PATH="$PATH:/mnt/d/Programs/Path:/mnt/d/Programs/Sioyek"
  export PATH="$PATH:/mnt/d/Programs/mpv"
fi

# General environment variables
export EDITOR="nvim" SUDO_EDITOR="nvim"
export HISTFILE="$HOME/.histfile" HISTSIZE=1000 SAVEHIST=1000

if [ "$ZSH_VERSION" != "" ]; then
  setopt SHARE_HISTORY
fi

# Set MANPAGER only if bat is installed
if command -v bat &> /dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# NixOs aliases
alias nix-shell="nix-shell --run zsh"
alias nrs="sudo nixos-rebuild switch --flake $(realpath ~/.config/nixos)#$(hostname)"
alias nrb="sudo nixos-rebuild boot --flake $(realpath ~/.config/nixos)#$(hostname)"
alias nrt="sudo nixos-rebuild test --flake $(realpath ~/.config/nixos)#$(hostname)"

alias hrs="home-manager switch --flake $(realpath ~/.config/nixos)#vault@$(hostname)"
alias hrb="home-manager build --flake $(realpath ~/.config/nixos)#vault@$(hostname)"

alias hibernate="systemctl hibernate"
alias rm="rm -I"

# bat-dependent aliases
if command -v bat &> /dev/null; then
  alias cat="bat"
  alias -g -- -h="-h 2>&1 | bat --language=help --style=plain"
  alias -g -- --help="--help 2>&1 | bat --language=help --style=plain"
fi

# exa-dependent aliases
if command -v exa &> /dev/null; then
  alias ls="exa"
fi

# ls-dependent aliases
alias z="cdi" # View it on .zshrc
alias ll="ls -alF"
alias la="ls -A"

# fzf and bat-dependent alias
if command -v fzf &> /dev/null && command -v bat &> /dev/null; then
  alias fzfp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
fi

# xclip-dependent aliases
if command -v xclip &> /dev/null; then
  alias c="xclip -sel c"
  alias p="xclip -sel c -o"
  alias cs="xclip"
  alias vs="xclip -o"
fi

# nvim-dependent aliases
if command -v nvim &> /dev/null; then
  alias v="nvim"
  alias vimdiff="nvim -d"
fi

# tmux-dependent aliases
if command -v tmux &> /dev/null; then
  alias t="tmux"
  alias ta="tmux attach"
  alias tad="tmux attach -d -t"
  alias tkss="tmux kill-session -t"
  alias tksv="tmux kill-server"
  alias tl="tmux list-sessions"
  alias ts="tmux new-session -s"
fi

# gh-dependent aliases
if command -v ghcs &> /dev/null; then
  alias \?="ghcs"
  alias \?\?="ghce"
fi

# Standard aliases
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ "$cwd" != "" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

function s() {
  exec </dev/tty
  exec <&1
  local session
  session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
  zle reset-prompt >/dev/null 2>&1 || true
  [[ -z "$session" ]] && return
  sesh connect "$session"
}

wtnvim() {
  if [ "$1" = "" ]; then
    echo "Usage: wtnvim <file>"
    return 1
  fi

  wezterm cli spawn -- zsh -l -i -c "
    cd \"$(dirname "$1")\" && \
    nvim \"$(realpath "$1")\"; \
    exec zsh"
}
