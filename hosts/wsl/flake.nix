# cd ~/dotfiles
# nix flake update
# sudo nixos-rebuild switch --flake .
# update
# nix-channel --update
# nix-collect-garbage -d
# sudo nix-collect-garbage -d
{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/nixos-wsl";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixos-wsl, home-manager, ... }:
  let
    username = "cte";
  in
    {
      nixosConfigurations = {
        dusk = let
          system = "x86_64-linux";
          specialArgs = { inherit inputs username; };
        in
          nixpkgs.lib.nixosSystem {
            inherit system specialArgs;

            modules = [
	      nixos-wsl.nixosModules.wsl
              ./default.nix
              home-manager.nixosModules.home-manager {
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
