#!/bin/bash

get_volume() {
    # Get the index of the default sink
    default_sink=$(pactl info | grep 'Default Sink' | cut -d: -f2 | xargs)

    # Get the volume of the default sink
    volume=$(pactl list sinks | awk -v default_sink="$default_sink" '
        $0 ~ "Name: "default_sink {
            in_default_sink = 1
        }
        in_default_sink && /Volume:/ {
            print $5
            exit
        }
    ')

    echo "$volume"
}
i3status | while :
do
    read line
    vol=$(get_volume)
    echo "Volume: $vol | $line" || exit 1
done

