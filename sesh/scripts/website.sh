tmux send-keys "nvim src/app.vue" C-m

tmux splitw -l 10
tmux send-keys "bun run dev" C-m

tmux select-pane -t 1
