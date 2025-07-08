# .profile - POSIX-compliant shell configuration
# This file should contain only shell-agnostic configurations that work in any POSIX shell

# General environment variables
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export BROWSER="wslview"  # Will be overridden by WSL check if needed

# XDG Base Directory Specification
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# History configuration (shell-agnostic)
export HISTSIZE=10000
export SAVEHIST=10000

# WSL-specific configuration
if grep -qi microsoft /proc/version 2>/dev/null; then
  export BROWSER="wslview"
  export PATH="$PATH:/mnt/d/Programs/Path:/mnt/d/Programs/Sioyek:/mnt/d/Programs/mpv"
fi

# Nix configuration
if [ -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
  . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi

# Home-manager configuration
if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

# Add user bin directories to PATH
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Set MANPAGER only if bat is installed
if command -v bat >/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi
