# if running bash
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# User binaries in PATH
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# WSL paths
if grep -qi microsoft /proc/version; then
  export BROWSER=wslview
  export PATH="$PATH:/mnt/d/Programs/Path:/mnt/d/Programs/Sioyek"
fi

# General environment variables
export EDITOR="nvim" SUDO_EDITOR="nvim"
export HISTFILE="$HOME/.histfile" HISTSIZE=1000 SAVEHIST=1000
setopt SHARE_HISTORY

# Aliases
alias z="cdi" View it on .zshrc
alias cat="bat"

alias ls="exa"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

alias fzfp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
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

alias t="tmux"
alias ta="tmux attach"
alias tad="tmux attach -d -t"
alias tkss="tmux kill-session -t"
alias tksv="tmux kill-server"
alias tl="tmux list-sessions"
alias tmuxconf="$EDITOR $ZSH_TMUX_CONFIG"
alias ts="tmux new-session -s"
. "$HOME/.cargo/env"
