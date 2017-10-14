#!/usr/bin/env bash

# Disable Ctrl-S/Ctrl-Q
stty -ixon;

# Bind open vim to Ctrl-V
bind '"\C-v":"vim \n"';

# Bind open vim to Ctrl-V
bind '"\C-s":"$(git stash-pick)\n"';

bind '"\C-q":"$(git modified-file-pick)\n"';
