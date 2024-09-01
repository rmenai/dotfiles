if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# # ADD WINDOWS PATH
# export BROWSER=wslview
# export PATH=$PATH:/mnt/c/Programs/Path:/mnt/c/"Program Files"/Docker/Docker/resources/bin
# export PATH=$PATH:/home/rami/.windows/bin
#
# alias notes="cd ~/Documents/Vaults/notes && nvim README.md"
#
# . "$HOME/.cargo/env"
#
# # Activate opam default switch
# eval $(opam env)
