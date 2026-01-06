#!/usr/bin/env bash

# Only show on servers (when connected via SSH)
[[ -z "$SSH_CONNECTION" ]] && exit 0

# Get theme colors from tmux
thm_peach=$(tmux show-option -gqv @thm_peach)
thm_crust=$(tmux show-option -gqv @thm_crust)

# Server icon
icon="󰒋"

echo "#[fg=${thm_crust},bg=${thm_peach}] ${icon} $(hostname) "
