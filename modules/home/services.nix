{ pkgs, ... }:

{
  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (pkgs.lib.getName pkg) [
  #     "dropbox"
  #   ];

  # services.dropbox.enable = true;
}
