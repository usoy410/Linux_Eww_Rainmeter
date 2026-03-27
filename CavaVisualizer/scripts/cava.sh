#!/bin/bash
cava -p <(echo "
[general]
bars = 10
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
bar_delimiter = 0
") | while read -r line; do
    echo "$line" | sed 's/0/ /g; s/1/▂/g; s/2/▃/g; s/3/▄/g; s/4/▅/g; s/5/▆/g; s/6/▇/g; s/7/█/g'
done
