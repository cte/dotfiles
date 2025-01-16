{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.space-mono
    nerd-fonts.geist-mono
    font-awesome
  ];

  environment.systemPackages = with pkgs; [
    # VM
    open-vm-tools

    # Nix
    nix-search-cli

    # Basic
    oh-my-zsh
    screen
    wget
    git
    neovim
    ripgrep
    killall

    # Audio
    pavucontrol
    spotify

    # Terminals
    wezterm
    kitty

    # Apps
    autokey
    _1password-gui
    dropbox-cli
    dropbox
    vscode
    code-cursor
    slack

    # Hyprland
    waybar
    rofi
    networkmanagerapplet
    hyprpaper
    btop
    cava

    # Gnome
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
  ];

  environment.gnome.excludePackages = with pkgs; [
    baobab      # disk usage analyzer
    eog         # image viewer
    epiphany    # web browser
    gedit       # text editor
    simple-scan # document scanner
    totem       # video player
    yelp        # help viewer
    evince      # document viewer
    file-roller # archive manager
    geary       # email client
    seahorse    # password manager
    snapshot    # camera

    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    # gnome-font-viewer
    # gnome-logs
    gnome-maps
    gnome-music
    gnome-photos
    # gnome-screenshot
    # gnome-system-monitor
    gnome-weather
    gnome-disk-utility
    gnome-connections
    gnome-tour
    # gnome-text-editor
  ];

  programs.zsh.enable = true;

  programs.firefox.enable = true;

  programs.hyprland.enable = true;

  documentation.nixos.enable = false;
}
