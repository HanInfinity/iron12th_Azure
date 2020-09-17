#!/bin/bash
base_url="https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/"
i=0
for file in "$@"
do
    filename="$(basename -- $file)"
    cp "$file" "D:\\prs\\iron12th_Azure\\uPic\\$filename"
    result[((i++))]="$base_url$filename"
done

echo "Upload Success:"
for url in "${result[@]}"
do
output="$url"
echo $output | sed 's/\\//g'
done