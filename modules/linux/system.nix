{ pkgs, lib, username, ... }:

{
  # USERS

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.defaultUserShell = pkgs.zsh;

  nix.settings = {
    trusted-users = [ username ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${username}";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # TIME

  time.timeZone = "America/Los_Angeles";

  # I18N

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # SERVICES

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.desktopManager.xterm.enable = false;
  # services.xserver.excludePackages = with pkgs; [ xterm ];

  # Configure keymap in X11. Also applies to Wayland.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this.
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # SECURITY

  # RTKit is a real-time scheduling service that allows applications (particularly audio applications) to request
  # real-time scheduling priorities in a secure way.
  security.rtkit.enable = true;

  # ngrok tcp --region=us --remote-addr=9.tcp.ngrok.io:25693 22
  # ssh -p 25693 cte@9.tcp.ngrok.io
  services.openssh = {
    enable = true;
    passwordAuthentication = true;
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  services.open-webui = {
    enable = true;
  };
}
