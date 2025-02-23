SESSION_NAME="School"

tmux send-keys -t $SESSION_NAME:1 "cd ~/Documents/projects/school/cs/ocaml/bin" C-m
tmux send-keys -t $SESSION_NAME:1 "nvim main.ml" C-m

tmux splitw -h
tmux send-keys "utop" C-m

tmux new-window -t $SESSION_NAME:2 -n "Exercices" -c ~/Documents/projects/school/cs
tmux send-keys -t $SESSION_NAME:2 "y" C-m
