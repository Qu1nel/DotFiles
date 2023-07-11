#!/bin/env bash
array=$(find . -type f -regex "\.\/[0-9]+\.png" | sort | sed "s|./||g" | xargs printf "%s ")

echo "convert ${array}-append $(date +%s).png"
convert ${array} -append "$(date +%s).png"

for file in ${array}; do
    rm -v "$file"
done
