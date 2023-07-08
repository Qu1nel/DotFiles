#!/bin/env bash
array=$(find . -type f -regex "\.\/[0-9]+\.png" -printf "%f ")

echo "convert ${array}-append $(date +%s).png"
convert ${array} -append "$(date +%s).png"

for file in ${array}; do
    rm -v "$file"
done
