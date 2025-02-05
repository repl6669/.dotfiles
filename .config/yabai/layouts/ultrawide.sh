#!/bin/bash

windows=$(yabai -m query --windows --display 1 | jq '[.[] | select(."is-visible"==true and ."is-floating"==false)] | length')

top_padding=$(yabai -m config top_padding)
bottom_padding=$(yabai -m config bottom_padding)
left_padding=$(yabai -m config left_padding)
right_padding=$(yabai -m config right_padding)

default_top_padding=10
default_bottom_padding=10
default_left_padding=10
default_right_padding=10
default_vertical_padding=10

width=$(yabai -m query --displays --display | jq '.frame.w')
height=$(yabai -m query --displays --display | jq '.frame.h')

function get_vertical_padding() {
	if [ "$windows" -lt 4 ]; then
		echo "80"
	else
		echo "$default_vertical_padding"
	fi
}

function get_horizontal_padding() {
	if [ "$windows" == 1 ]; then
		echo "$((${width%.*} / 4))"
	else
		echo "$((${width%.*} / (windows + 1) / 2))"
	fi
}

function set_padding() {
	if [ "$windows" -lt 4 ]; then
		yabai -m config top_padding "$(get_vertical_padding)" \
			bottom_padding "$(get_vertical_padding)" \
			left_padding "$(get_horizontal_padding)" \
			right_padding "$(get_horizontal_padding)"
	else
		yabai -m config left_padding $default_left_padding \
			right_padding $default_right_padding
	fi
}
set_padding
yabai -m space --balance
