#!/usr/bin/env bash

# Usage:
# ./install.sh <package> <package> ...

if [ $# -eq 0 ]; then
    echo "Error: No directories specified"
    echo "Usage: $0 dir1 dir2 ..."
    exit 1
fi

dirs=("$@")

for dir in "${dirs[@]}"; do
  echo $dir
  stow -t ~ $dir
done
