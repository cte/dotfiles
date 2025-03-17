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

    # Programming
    rustc
    cargo
    go
    jdk
    cmake
    uv
  ];

  programs.zsh.enable = true;
}
