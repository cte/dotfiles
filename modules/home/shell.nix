{ pkgs, username, ... }:

let
  configDir = "/home/${username}/dotfiles";
in {
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
      update = "sudo nixos-rebuild switch --flake ${configDir}";
    };

    initExtra = ''
      export EDITOR=nvim;
      export HISTSIZE=100000;
      export SAVEHIST=100000;
      export HISTFILE="$HOME/.zsh_history";
      export PATH="$HOME/.local/bin:$PATH";
      export SCREENDIR="$HOME/.screen";
      # Disable GPU acceleration for Kitty.
      export LIBGL_ALWAYS_SOFTWARE=true;
      export GALLIUM_DRIVER=llvmpipe;

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

  programs.starship.enable = true;
}
