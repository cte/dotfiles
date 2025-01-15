{ config, pkgs, ... }:
let
  username = "cte";
  email = "cestreich@gmail.com";
  homeDir = "/home/${username}";
  configDir = "${homeDir}/dotfiles";
in {
  home.username = "${username}";
  home.homeDirectory = "${homeDir}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
  ];

  home.file = {
    ".wezterm.lua".source = ./wezterm.lua;
    ".config/starship.toml".source = ./starship.toml;
  };

  home.sessionVariables = {
    HISTSIZE = 100000;
    SAVEHIST = 100000;
    HISTFILE = "~/.zsh_history";
    EDITOR = "nvim";
    PATH = "$HOME/.local/bin:$PATH";
    SCREENDIR = "$HOME/.screen";
  };

  # https://mynixos.com/home-manager/options/programs.zsh
  programs.zsh = {
    enable = true;

    shellAliases = {
      ls = "ls -al --color";
      mv = "mv -iv";
      cp = "cp -iv";
      rm = "rm -iv";
      ".." = "cd ..";
      screen = "TERM=screen screen";
      psg = "ps -ef | grep -v grep | grep $*";
      getpid = "getpid() { ps -ef | grep -v grep | grep \"$1\" | awk '{print $2}'; }; getpid";
      lspid = "lspid() { ps -ef | grep -v grep | grep $* | awk '{ printf $2 \" \"; for (i = 8; i < NF; i++) printf $i \" \"; print $NF }'; }; lspid";
      ports="sudo ss -lptn";
      gogh = "bash -c \"$(wget -qO- https://git.io/vQgMr)\"";
      update-system = "sudo nixos-rebuild switch --flake ${configDir}";
      update-home = "home-manager switch --flake ${configDir}";
    };

    initExtra = ''
      setopt histignorealldups sharehistory localoptions nullglob

      autoload -Uz compinit && compinit
      zstyle ':completion:*' auto-description 'specify: %d'
      zstyle ':completion:*' completer _expand _complete _correct _approximate
      zstyle ':completion:*' format 'Completing %d'
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' menu select=2
      zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' list-colors '''
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' matcher-list ''' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
      zstyle ':completion:*' menu select=long
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' use-compctl false
      zstyle ':completion:*' verbose true
      zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
      zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

      # ssh - https://docs.docker.com/desktop/dev-environments/create-dev-env/
      SSH_ENV="$HOME/.ssh/agent-environment"

      function start_agent {
        mkdir -p ~/.ssh
        ssh-agent | sed 's/^echo/#echo/' > "''${SSH_ENV}"
        chmod 600 "''${SSH_ENV}"
        . "''${SSH_ENV}" > /dev/null
      }

      if [ -f "''${SSH_ENV}" ]; then
        . "''${SSH_ENV}" > /dev/null
        ps -ef | grep ''${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
          start_agent;
        }
      else
        start_agent;
      fi

      for pubkey in $HOME/.ssh/{id_*,*.pem}; do
        if grep -q PRIVATE "$pubkey"; then
          ssh-add "$pubkey" # 2>/dev/null
        fi
      done

      # asdf - https://asdf-vm.com/
      [ -f $HOME/.asdf/asdf.sh ] && . $HOME/.asdf/asdf.sh

      # NVM - https://github.com/nvm-sh/nvm
      if [ -d "$HOME/.nvm" ]; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      fi

      # Direnv - https://direnv.net/
      if command -v direnv >/dev/null 2>&1; then
        eval "$(direnv hook zsh)"
      fi
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "node" "aws" ];
    };
  };

  # https://mynixos.com/home-manager/options/programs.git
  programs.git = {
    enable = true;
    userName = "${username}";
    userEmail = "${email}";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.starship.enable = true;

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "dropbox"
    ];

  services.dropbox.enable = true;

  # gnome

  gtk = {
    enable = true;

    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.papirus-icon-theme;
    # };

    theme = {
      name = "orchis";
      package = pkgs.orchis-theme;
    };

    # cursorTheme = {
    #   name = "Numix-Cursor";
    #   package = pkgs.numix-cursor-theme;
    # };

    # gtk3.extraConfig = {
    #   Settings = ''
    #     gtk-application-prefer-dark-theme=1
    #   '';
    # };

    # gtk4.extraConfig = {
    #   Settings = ''
    #     gtk-application-prefer-dark-theme=1
    #   '';
    # };
  };

  home.sessionVariables.GTK_THEME = "orchis";

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
          "org.wezfurlong.wezterm.desktop"
          "firefox.desktop"
          "1password.desktop"
          "code.desktop"
          "cursor.desktop"
        ];
        disable-user-extensions = false;
        enabled-extensions = [
          "arcmenu@arcmenu.com"
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
    };
  };
}
