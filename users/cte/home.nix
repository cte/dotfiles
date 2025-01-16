{ pkgs, ... }:

{
  imports = [
    ../../modules/home/core.nix
    ../../modules/home/config.nix
    ../../modules/home/shell.nix
    ../../modules/home/gnome.nix
    # ../../modules/home/packages.nix
    ../../modules/home/programs.nix
    ../../modules/home/services.nix
  ];
}
