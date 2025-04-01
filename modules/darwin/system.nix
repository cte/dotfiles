# https://daiderd.com/nix-darwin/manual/index.html#sec-options
{ pkgs, username, hostname, ... }:

{
  users.users."${username}"= {
    description = username;
    home = "/Users/${username}";
  };

  nix.settings = {
    trusted-users = [ username ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix.package = pkgs.nix;

  system = {
    stateVersion = 5;

    # activationScripts are executed every time you boot the system or run
    # `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true;
      # Other macOS's defaults configuration.
    };
  };

  # Add ability to used TouchID for sudo authentication.
  security.pam.enableSudoTouchIdAuth = true;

  networking.hostName = "${hostname}";
  networking.computerName = "${hostname}";

  system.defaults.smb.NetBIOSName = "${hostname}";
}
