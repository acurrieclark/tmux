#!/usr/bin/env bash

# Check for battery presence
has_battery() {
  if [[ "$(uname)" == "Darwin" ]]; then
    pmset -g batt 2>/dev/null | grep -q "InternalBattery"
  else
    # Linux: check upower or /sys/class/power_supply/BAT*
    upower -e 2>/dev/null | grep -q battery || ls /sys/class/power_supply/BAT* &>/dev/null
  fi
}

has_battery || exit 0

# Get theme colors from tmux
thm_lavender=$(tmux show-option -gqv @thm_lavender)
thm_crust=$(tmux show-option -gqv @thm_crust)
thm_fg=$(tmux show-option -gqv @thm_fg)
thm_surface_0=$(tmux show-option -gqv @thm_surface_0)
separator=$(tmux show-option -gqv @catppuccin_status_left_separator)

# Get battery info
BATTERY_DIR="$HOME/.config/tmux/plugins/tmux-battery/scripts"
icon=$("$BATTERY_DIR/battery_icon.sh")
percentage=$("$BATTERY_DIR/battery_percentage.sh")

# Output formatted segment
echo "#[fg=${thm_lavender}]${separator}#[fg=${thm_crust},bg=${thm_lavender}]${icon} #[fg=${thm_fg},bg=${thm_surface_0}] ${percentage}#[fg=${thm_surface_0}] "
