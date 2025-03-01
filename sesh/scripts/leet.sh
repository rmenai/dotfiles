SESSION_NAME="LeetCode"

tmux send-keys -t "$SESSION_NAME":1 "nvim leet" C-m

tmux new-window -t "$SESSION_NAME":2 -n "Rust" -c ~/Documents/Sandbox/leetcode
tmux send-keys -t "$SESSION_NAME":2 "nvim src/main.rs" C-m

tmux select-window -t "$SESSION_NAME":1
