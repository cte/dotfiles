{ pkgs, ... }:

{
  imports = [
    ../../modules/darwin/system.nix
    ../../modules/darwin/packages.nix
  ];
}
