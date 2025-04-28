#!/bin/bash
from=$1
to=$2
find "$from" -type f | while read file; do
    filename=$(basename "$file")
    name="${filename%.*}"
    ext="${filename##*.}"
    if [ "$name" = "$filename" ]; then
        ext=""
        newname="$name"
    else
        newname="$name.$ext"
    fi
    count=1
    temp="$newname"
    while [ -f "$to/$temp" ]; do
        if [ -n "$ext" ]; then
            temp="${name}${count}.${ext}"
        else
            temp="${name}${count}"
        fi
        count=$((count + 1))
    done
    cp "$file" "$to/$temp"
done