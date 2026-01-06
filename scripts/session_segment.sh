#!/usr/bin/env bash

# Get session name and prefix state
session=$(tmux display-message -p '#S')
prefix=$(tmux display-message -p '#{client_prefix}')

# Get theme colors from tmux
thm_red=$(tmux show-option -gqv @thm_red)
thm_green=$(tmux show-option -gqv @thm_green)
thm_crust=$(tmux show-option -gqv @thm_crust)
thm_fg=$(tmux show-option -gqv @thm_fg)
thm_surface_0=$(tmux show-option -gqv @thm_surface_0)
thm_sapphire=$(tmux show-option -gqv @thm_sapphire)
separator=$(tmux show-option -gqv @catppuccin_status_left_separator)
icon=$(tmux show-option -gqv @catppuccin_session_icon)

# Choose color based on prefix state
if [[ "$prefix" == "1" ]]; then
  color="$thm_red"
else
  color="$thm_green"
fi

# Build segment - always show icon, only show name if not numeric
if [[ "$session" =~ ^[0-9]+$ ]]; then
  # Numeric session - icon only, bleed into datetime segment
  echo "#[fg=${color}]${separator}#[fg=${thm_crust},bg=${color}]${icon}#[fg=${thm_sapphire},bg=${color}]${separator}#[fg=${thm_crust},bg=${thm_sapphire}]"
else
  # Named session - icon + name
  echo "#[fg=${color}]${separator}#[fg=${thm_crust},bg=${color}]${icon}#[fg=${thm_fg},bg=${thm_surface_0}] ${session}#[fg=${thm_surface_0}] "
fi
