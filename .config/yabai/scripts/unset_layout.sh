#!/bin/bash

# Path to temp flag file
flag_file="/tmp/yabai_layout_flag"

unset_layout() {
	if [ -f "$flag_file" ]; then
		rm $flag_file
	fi
}

unset_layout
