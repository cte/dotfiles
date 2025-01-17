#!/usr/bin/env bash

dirs=("bin" "btop" "cava" "code" "cursor" "fonts" "hypr" "hyprpanel" "kitty" "nvim" "rofi" "starship" "wezterm")

for dir in "${dirs[@]}"; do
  echo $dir
  stow -t ~ $dir
done
