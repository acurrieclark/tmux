# Tmux Configuration Agent Guidelines

## Overview
This is a tmux configuration directory with tmux.conf and gitmux.yml files. No build/test commands needed - configuration files are reloaded via tmux.

## Configuration Management
- Main config: `tmux.conf` - tmux configuration with plugins and key bindings
- Git status: `gitmux.yml` - gitmux configuration for git info in status bar
- Reload config: `tmux source-file ~/.config/tmux/tmux.conf` or use prefix + r

## Style Guidelines
- Use 2-space indentation for YAML files
- Comment structure: `# Comment` for tmux.conf, standard YAML comments for gitmux.yml
- Key bindings follow vim-style navigation (h/j/k/l)
- Color scheme: Catppuccin Mocha theme
- Prefix key: § (section symbol)

## File Conventions
- tmux.conf: Standard tmux configuration syntax with set/bind commands
- gitmux.yml: YAML configuration with symbols, styles, and layout sections
- Comments include ASCII art headers and descriptive inline comments
- Plugin management via TPM (Tmux Plugin Manager)

## Key Areas
- Plugins loaded via @plugin directives
- Custom key bindings for splits, navigation, and vim integration
- Status bar customization with git integration via gitmux
- Session management integration with sesh and fzf

## Gotchas

### Status bar with shell commands
- Use `set -ag` (not `set -agF`) when status-right/left contains `#()` shell commands
- `-F` flag expands formats immediately at config load time, breaking `#()` execution
- Status bar is built **after** `run '~/.config/tmux/plugins/tpm/tpm'` so catppuccin theme vars are available
- tmux-battery plugin interpolates `#{battery_*}` vars only in status options that exist when TPM runs; since we set status-right after TPM, call battery scripts directly
- Battery segment uses wrapper script `~/.config/tmux/scripts/battery_segment.sh` which detects battery presence (macOS: pmset, Linux: upower or /sys/class/power_supply/BAT*) and outputs nothing on servers without batteries
- Session segment uses wrapper script `~/.config/tmux/scripts/session_segment.sh` which hides session name for unnamed (numeric) sessions but always shows the prefix indicator icon