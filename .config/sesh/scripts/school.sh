SESSION_NAME="School"

tmux rename-window -t $SESSION_NAME:1 "C"
tmux send-keys -t $SESSION_NAME:1 "cd ~/Documents/projects/school/c/src" C-m
tmux send-keys -t $SESSION_NAME:1 "nvim test.c" C-m

tmux new-window -t $SESSION_NAME:2 -n "Ocaml" -c ~/Documents/projects/school/ocaml/bin
tmux send-keys -t $SESSION_NAME:2 "nvim main.ml" C-m

tmux select-window -t $SESSION_NAME:1
