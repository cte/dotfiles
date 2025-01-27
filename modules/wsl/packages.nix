{ pkgs, lib, config, ... }:

{
  environment.systemPackages = with pkgs; [
    # Nix
    nix-search-cli

    # Basic
    screen
    wget
    git
    zig # https://github.com/LazyVim/LazyVim/discussions/1920#discussioncomment-9810412
    neovim
    ripgrep
    killall

    # Shell
    zinit

    # Hyprland
    btop
    stow
    nitch
  ];

  programs.zsh.enable = true;

  documentation.nixos.enable = false;

  # https://www.reddit.com/r/NixOS/comments/fsummx/how_to_list_all_installed_packages_on_nixos/
  environment.etc."current-system-packages".text =
    let
      packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
      formatted;
}
