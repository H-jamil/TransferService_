#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <destination> <num_files> <file_size>"
    exit 1
fi

# Assign variables from arguments
dest_dir="$1"
num_files="$2"
file_size="$3"

# Create directory if it doesn't exist
if [ ! -d "$dest_dir" ]; then
    mkdir "$dest_dir"
fi

# Create num_files of file_size bytes
for ((i=1; i<=num_files; i++))
do
    dd if=/dev/zero of="$dest_dir"/file"$i".txt bs=1024 count="$file_size" >/dev/null 2>&1
done

echo "Created $num_files files of size $file_size bytes in $dest_dir"
