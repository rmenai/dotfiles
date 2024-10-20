if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  . /home/rami/.nix-profile/etc/profile.d/nix.sh
fi

if grep -qi microsoft /proc/version; then
  # Add Windows-specific paths and variables
  export BROWSER=wslview
  export PATH=$PATH:/mnt/c/Programs/Path:/mnt/c/"Program Files"/Docker/Docker/resources/bin
  export PATH="$PATH:/mnt/c/Programs/Sioyek"
fi

# Aliases
alias notes="cd ~/Documents/Vaults/notes && nvim README.md"

# # Activate opam default switch
# eval $(opam env)
