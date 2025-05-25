#!/usr/bin/env bash

tmux send-keys "rust-competitive-helper" C-m
tmux send-keys C-m

tmux splitw -h

tmux send-keys "rust-competitive-helper" C-m
tmux send-keys Down
