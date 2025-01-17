{ pkgs, ... }:

{
  home.file = {
    # ".config/starship.toml".source = ../../config/starship/starship.toml;
    # ".wezterm.lua".source = ../../config/wezterm/wezterm.lua;
    # ".config/kitty/kitty.conf".source = ../../config/kitty/kitty.conf;
    # ".config/hypr/hyprland.conf".source = ../../config/hypr/hyprland.conf;

    # https://nixos.wiki/wiki/Fonts
    # cp ~/dotfiles/fonts/* ~/.local/share/fonts
  };
}
