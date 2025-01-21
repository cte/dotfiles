{ pkgs, username, ... }:

let
  configDir = "/home/${username}/dotfiles";
in {
  # https://mynixos.com/home-manager/options/programs.zsh
  programs.zsh = {
    enable = true;

    shellAliases = {
      ls = "eza -al";
      mv = "mv -iv";
      cp = "cp -iv";
      rm = "rm -iv";
      ".." = "cd ..";
      cat = "bat";
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
      export PATH="$HOME/.local/bin:$PATH";
      export SCREENDIR="$HOME/.screen";

      # History
      export HISTSIZE=100000;
      export SAVEHIST=100000;
      export HISTFILE="$HOME/.zsh_history";
      export HISTDUP=erase;
      setopt appendhistory;
      setopt sharehistory;
      setopt hist_ignore_space;
      setopt hist_ignore_all_dups;
      setopt hist_save_no_dups;
      setopt hist_ignore_dups;
      setopt hist_find_no_dups;
      autoload -Uz history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      bindkey "$terminfo[kcuu1]" history-beginning-search-backward-end
      bindkey "$terminfo[kcud1]" history-beginning-search-forward-end

      # Zinit - https://github.com/zdharma-continuum/zinit
      # https://www.youtube.com/watch?v=ud7YxC33Z3w
      ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
      [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
      [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
      source "''${ZINIT_HOME}/zinit.zsh"

      # Plugins
      zinit light zsh-users/zsh-syntax-highlighting
      zinit light zsh-users/zsh-completions
      zinit light zsh-users/zsh-autosuggestions
      zinit light Aloxaf/fzf-tab

      # Snippets
      zinit snippet OMZP::git
      zinit snippet OMZP::sudo
      zinit snippet OMZP::aws
      zinit snippet OMZP::command-not-found

      # Completions
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
      autoload -Uz compinit && compinit

      zinit cdreplay -q

      # If a glob pattern doesn't match any files, it expands to nothing (empty list)
      setopt nullglob

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
          ssh-add "$pubkey" 2>/dev/null
        fi
      done
    '';
  };

  programs.starship.enable = true;
  programs.direnv.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;
}
