#!/usr/bin/env bash

dirs=("bin" "btop" "cava" "fonts" "hypr" "starship" "wezterm")

for dir in "${dirs[@]}"; do
  echo $dir
  stow -t ~ $dir
done
