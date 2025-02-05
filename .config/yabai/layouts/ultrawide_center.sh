#!/bin/bash

windows=$(yabai -m query --windows --display 1 | jq '[.[] | select(."is-visible"==true and ."is-floating"==false)] | length')

if [[ $windows == 1 ]]; then
	yabai -m config left_padding     1080 \
					right_padding    1080 \
					top_padding      10   \
					bottom_padding   10 
elif [[ $windows == 2 ]]; then
	yabai -m config left_padding     720 \
					right_padding    720 \
					top_padding      10  \
					bottom_padding   10 
elif [[ $windows == 3 ]]; then
	yabai -m config left_padding     360 \
					right_padding    360 \
					top_padding      10  \
					bottom_padding   10 
elif [[ $windows == 4 ]]; then
	yabai -m config left_padding     10 \
					right_padding    10 \
					top_padding      10 \
					bottom_padding   10 
fi

yabai -m space --balance
