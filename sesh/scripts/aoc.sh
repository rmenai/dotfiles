tmux send-keys "y src/bin" C-m

tmux splitw -l 10
tmux send-keys "cargo today"

tmux select-pane -t 1
