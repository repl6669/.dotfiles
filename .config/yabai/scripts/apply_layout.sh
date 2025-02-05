#!/bin/bash

# Path to temp flag file
layout_script="/tmp/yabai_layout_flag"
layout_dir="$HOME/.config/yabai/layouts"

# Read first line from flag_file

if [ -f "$layout_script" ]; then
	layout=$(cat $layout_script)
else
	layout=""
fi

layout_script="$layout_dir/$layout.sh"

apply_layout() {
	if [ -f "$layout_script" ]; then
		source "$layout_script"
	fi
}

apply_layout
