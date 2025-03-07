{ pkgs, ... }:

{
  dconf = {
    enable = true;

    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        accent-color = "red";
      };

      "org/gnome/desktop/wm/keybindings" = {
        switch-applications = ["<Control>Tab"];
        switch-applications-backward = ["<Shift><Control>Tab"];
      };

      "org/gnome/shell" = {
        favorite-apps = [
          "com.mitchellh.ghostty.desktop"
          "firefox.desktop"
          "1password.desktop"
          "code.desktop"
          "cursor.desktop"
          "dropbox.desktop"
          "spotify.desktop"
          "vesktop.desktop"
        ];
        disable-user-extensions = false;
        enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "just-perfection-desktop@just-perfection"
          "system-monitor@gnome-shell-extensions.gcampax.github.com"
        ];
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        disable-overview-on-startup = true;
        dock-position = "LEFT";
        dock-fixed = true;
        dash-max-icon-size = 24;
        custom-theme-shrink = true;
        transparency-mode = "FIXED";
        background-opacity = 0.0;
      };

      "org/gnome/shell/extensions/system-monitor" = {
        show-swap = false;
        show-upload = false;
        show-download = false;
      };
    };
  };
}
