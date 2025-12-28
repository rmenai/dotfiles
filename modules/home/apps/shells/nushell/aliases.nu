# Standard system aliases
alias hibernate = systemctl hibernate
alias suspend = systemctl suspend

# Standard ls aliases
alias ll = ls -l
alias la = ls -a

# Tool replacements
alias cat = bat
alias fzfp = fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"

# # xclip dependent aliases
# alias c = clipboard copy
# alias p = clipboard paste

# nvim dependent aliases
alias v = nvim
alias vimdiff = nvim -d

alias r = nix repl
alias g = nvim +Neogit

# tmux dependent aliases
alias t = tmux
alias ta = tmux attach
alias tad = tmux attach -d -t
alias tkss = tmux kill-session -t
alias tksv = tmux kill-server
alias tl = tmux list-sessions
alias ts = tmux new-session -s

# atuin dependent aliases
alias a = atuin
alias ast = atuin stats
alias asr = atuin scripts run
alias asn = atuin scripts new
alias asd = atuin scripts delete
alias asl = atuin scripts list

# wormhole-rs aliase
alias warp = wormhole-rs

# gh dependent aliases
alias "?" = gh copilot suggest
alias "??" = gh copilot explain
