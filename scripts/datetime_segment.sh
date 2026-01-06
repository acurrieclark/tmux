#!/usr/bin/env bash

# Get session name to check if numeric
session=$(tmux display-message -p '#S')

# Get theme colors from tmux
thm_sapphire=$(tmux show-option -gqv @thm_sapphire)
thm_crust=$(tmux show-option -gqv @thm_crust)
thm_fg=$(tmux show-option -gqv @thm_fg)
thm_surface_0=$(tmux show-option -gqv @thm_surface_0)
separator=$(tmux show-option -gqv @catppuccin_status_left_separator)

# Clock icon
icon="󰃰"

# Get current date/time
datetime=$(date +" %y-%m-%d %H:%M")

# Build segment - skip separator if session is numeric (already output by session segment)
if [[ "$session" =~ ^[0-9]+$ ]]; then
  # Numeric session - no separator (session segment already output it)
  echo "#[fg=${thm_crust},bg=${thm_sapphire}]${icon} #[fg=${thm_fg},bg=${thm_surface_0}]${datetime}#[fg=${thm_surface_0}] "
else
  # Named session - full segment with separator
  echo "#[fg=${thm_sapphire}]${separator}#[fg=${thm_crust},bg=${thm_sapphire}]${icon} #[fg=${thm_fg},bg=${thm_surface_0}]${datetime}#[fg=${thm_surface_0}] "
fi
