{ pkgs, ... }:

{
  imports = [
    ../../modules/home/core.nix
    ../../modules/home/config.nix
    ../../modules/home/shell.nix
    ../../modules/home/packages.nix
    ../../modules/home/programs.nix
  ];
}
