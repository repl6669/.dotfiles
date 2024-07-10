#!/bin/bash

windows=$(yabai -m query --windows --display 1 | jq '[.[] | select(."is-visible"==true and ."is-floating"==false)] | length')

if [[ $windows == 1 ]]; then
	yabai -m config left_padding     1200 \
					right_padding    1200 \
	&& yabai -m space --balance
elif [[ $windows == 2 ]]; then
	yabai -m config left_padding     800  \
					right_padding    800  \
	&& yabai -m space --balance
elif [[ $windows == 3 ]]; then
	yabai -m config left_padding     400  \
					right_padding    400  \
	&& yabai -m space --balance
elif [[ $windows == 4 ]]; then
	yabai -m config left_padding     10   \
					right_padding    10   \
	&& yabai -m space --balance
fi
