# Bootstrap:
# nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/hosts/rune#rune
#
# Update:
# darwin-rebuild switch --flake ~/dotfiles/hosts/rune#rune

{
  description = "Nix for macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm.url = "github:wez/wezterm?dir=nix";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    username = "cte";
  in
    {
      darwinConfigurations = {
        rune = let
          system = "aarch64-darwin";
          specialArgs = { inherit inputs username; };
        in
          nix-darwin.lib.darwinSystem {
            inherit system specialArgs;

            modules = [
              ./default.nix
              home-manager.darwinModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.${username} = import ./home.nix;
              }
            ];
          };
      };
    };
}