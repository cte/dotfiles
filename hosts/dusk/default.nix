{ ... }:

{
  imports =
    [
      ../../modules/system.nix
      ../../modules/nvidia.nix
      ../../modules/packages.nix
      ./hardware-configuration.nix
    ];

  boot.supportedFilesystems = [ "ntfs" ];

  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

  networking.hostName = "dusk";
  networking.networkmanager.enable = true; # Enable networking.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
