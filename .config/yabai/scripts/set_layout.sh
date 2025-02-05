#!/bin/bash

# Path to temp flag file
flag_file="/tmp/yabai_layout_flag"

# # Read first line from flag_file
# layout=$(cat $flag_file)

set_layout() {
	if [ -f "$flag_file" ]; then
		echo "$1" >$flag_file
	else
		touch "$flag_file"
		echo "$1" >$flag_file
	fi
}

set_layout "$1"

source "$HOME/.config/yabai/scripts/apply_layout.sh"
