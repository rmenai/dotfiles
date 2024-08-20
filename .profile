if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	      . "$HOME/.bashrc"
    fi
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Custom aliases 
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias notes="cd ~/Documents/Vaults/notes && nvim README.md"

# # Wslu configure browser
# export BROWSER=wslview
#
# # ADD WINDOWS PATH
# export PATH=$PATH:/mnt/c/Programs/Path
# export PATH=$PATH:/home/rami/.windows/bin

. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh --no-use" ] && \. "$NVM_DIR/nvm.sh --no-use"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# DENO
export DENO_INSTALL="/$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Activate opam default switch
eval $(opam env)
