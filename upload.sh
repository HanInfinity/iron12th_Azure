#!/bin/bash
base_url="https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/"
i=0
for file in "$@"
do
filename="$(basename $file)"
echo "$filename"
cp "$file" "D:\\Jesse_Chang\\pprs\\azure_docs\\uPic\\$filename"
output="$base_url$filename"
echo $output | sed 's/\\//g'
done

echo "Upload Success"