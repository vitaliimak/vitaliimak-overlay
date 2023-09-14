#! /usr/bin/env bash

# Check if the user provided the correct number of arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 <input_file> <output_file>"
  exit 1
fi

# Input file
input_file="$1"

# Check if the input file exists
if [ ! -e "$input_file" ]; then
  echo "File not found: $input_file"
  exit 1
fi

# Output file
output_file="$2"

# Calculate the size of the file in bytes
file_size=$(stat -c %s "$input_file")

# Calculate the BLAKE2B hash and takes only the hash value
blake2b=$(b2sum "$input_file" | awk '{print $1}')

# Calculate the SHA512 hash and takes only the hash value
sha512=$(sha512sum "$input_file" | awk '{print $1}')

# Extract the file name from the absolute path
file_name=$(basename "$input_file")

# Save the information to the output file
echo "DIST $file_name $file_size BLAKE2B $blake2b SHA512 $sha512" >> "$output_file"

echo "File size has been saved to $output_file"
