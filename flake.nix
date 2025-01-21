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

    wezterm.url = "github:wez/wezterm?dir=nix";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel = {
      url = "github:jas-singhfsu/hyprpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }@inputs:
  let
    system = "x86_64-linux";
    nixpkgsConfig = {
      nixpkgs.overlays = [
        inputs.hyprpanel.overlay
      ];
      nixpkgs.config.allowUnfree = true;
    };
  in
    {
      nixosConfigurations = {
        dusk = let
          username = "cte";
          specialArgs = { inherit inputs username; };
        in
          nixpkgs.lib.nixosSystem {
            inherit system;
            inherit specialArgs;
            modules = [
              ./hosts/dusk
              home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.${username} = import ./users/${username}/home.nix;
              }
              nixpkgsConfig
            ];
          };
      };
  };
}
