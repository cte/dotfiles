{ pkgs, username, ... }:

{
  # https://mynixos.com/home-manager/options/programs.git
  programs.git = {
    enable = true;
    userName = "${username}";
    userEmail = "cestreich@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
