{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.space-mono
    nerd-fonts.geist-mono
    nerd-fonts.noto
    nerd-fonts.symbols-only
    monaspace
  ];

  environment.systemPackages = with pkgs; [
    # Nix
    nix-search-cli

    # Basic
    # screen - Already comes with macOS.
    wget
    git
    neovim
    ripgrep
    # killall - Already comes with macOS.
    watch
    coreutils # timeout, etc

    # Terminals
    wezterm

    # Shell
    zinit

    # CLI
    btop
    # cava - Only works with PulseAudio.
    stow
    # nitch - Not available on macOS.
    neofetch

    # Work
    # asdf-vm - Using mise-en-place
    # gh - Installed via brew to get the latest version

    # Desktop
    spotify
    discord
    vscode
    slack
  ];

  # Other software to check for nix integration:
  # - Raycast
  # - 1Password
  # - Cursor
  # - Dropbox
  # - Docker Desktop
  # - Firefox
  # - Screen Studio
  # - DataGrip
  # - Notion Mail
  # - Yaak
  # - Zoom

  programs.zsh.enable = true;
}
