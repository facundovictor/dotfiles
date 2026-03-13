#!/usr/bin/env bash

alias battery='upower -i "$(upower -e | grep BAT)"'
