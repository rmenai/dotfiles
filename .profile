# Bash config
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# WSL config 
if grep -qi microsoft /proc/version; then
  export BROWSER=wslview
  export PATH="$PATH:/mnt/d/Programs/Path:/mnt/d/Programs/Sioyek"
  export PATH="$PATH:/mnt/d/Programs/mpv"
fi

if [ -f /etc/NIXOS ]; then
  alias nrs="sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)"
  alias nrb="sudo nixos-rebuild boot --flake /etc/nixos#$(hostname)"
  alias nrt="sudo nixos-rebuild test --flake /etc/nixos#$(hostname)"
fi

# General environment variables
export EDITOR="nvim" SUDO_EDITOR="nvim"
# export HISTFILE="$HOME/.histfile" HISTSIZE=1000 SAVEHIST=1000
# setopt SHARE_HISTORY

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Aliases
alias z="cdi" # View it on .zshrc
alias cat="bat"

alias ls="exa"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

alias fzfp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias -g -- -h="-h 2>&1 | bat --language=help --style=plain"
alias -g -- --help="--help 2>&1 | bat --language=help --style=plain"

alias c="xclip -sel c"
alias p="xclip -sel c -o"

alias cs="xclip"
alias vs="xclip -o"

alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias v="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"

alias t="tmux"
alias ta="tmux attach"
alias tad="tmux attach -d -t"
alias tkss="tmux kill-session -t"
alias tksv="tmux kill-server"
alias tl="tmux list-sessions"
alias ts="tmux new-session -s"

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
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
  sesh connect $session
}
