{ pkgs, lib, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.space-mono
    nerd-fonts.geist-mono
    nerd-fonts.noto
    nerd-fonts.symbols-only
  ];

  environment.systemPackages = with pkgs; [
    # Nix
    nix-search-cli

    # Basic
    oh-my-zsh
    screen
    wget
    git
    zig # https://github.com/LazyVim/LazyVim/discussions/1920#discussioncomment-9810412
    neovim
    ripgrep
    fastfetch
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
    hyprpaper
    hyprlock
    hyprpanel
    hypridle
    libnotify
    rofi
    btop
    cava
    stow

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
