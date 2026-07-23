#!/bin/sh
# setup essential dot files for current non-privileged user
set -xeuo pipefail

[ -f ~/.gdbinit ] || cat <<'EOF' > ~/.gdbinit
# ~/.gdbinit
set logging file ~/gdb.log
set logging enabled on
set pagination off
set trace-commands on
EOF

[ -f ~/.tmux.conf ] || cat <<'EOF' > ~/.tmux.conf
# Tip: you can show current global options with: Ctrl-B :show-options -g
set-option -g status-style bg=red
set-option -g status-right "#{?window_bigger,[#{window_offset_x}#,#{window_offset_y}] ,}\"#{=31:pane_title}\" %H:%M"
set-option -g status-right-length 50
# Enable Vi mode for copy & paste with keyboard (no mouse needed)
# see https://superuser.com/a/693990
setw -g mode-keys vi
bind-key -T copy-mode-vi 'v' send -X begin-selection     # Begin selection in copy mode.
bind-key -T copy-mode-vi 'C-v' send -X rectangle-toggle  # Begin selection in copy mode.
bind-key -T copy-mode-vi 'y' send -X copy-selection      # Yank selection in copy mode.
# copy mode: C-b [ - enter copy mode (use hjkl to move), Space or 'v' to start selection
# 'y' or ENTER to yank selection. use C-b = to list buffers, C-b ] to paste latest buffer
EOF

# Note: we don't setup ~/.gitconfig to avoid disclosing my personal e-mail...
exit 0
