#!/usr/bin/env bash

# Disable Ctrl-S/Ctrl-Q
stty -ixon;

# Bind open vim to Ctrl-V
bind '"\C-v":"vim \n"';

# Bind delete from cursor to end of word
bind '"\C-f":"\ed"';

# Bind git stash-pick to C-s
#shellcheck disable=SC2016
bind '"\C-s":"$(git stash-pick)\n"';

# Bind git modified-file-pick to C-q
#shellcheck disable=SC2016
bind '"\C-q":"$(git modified-file-pick)\n"';
