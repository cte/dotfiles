# cd ~/dotfiles
# sudo nixos-rebuild switch --flake .
# home-manager switch --flake .
{
  description = "cte / Dusk";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    wezterm.url = "github:wez/wezterm?dir=nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.dusk = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ ./configuration.nix ];
      };
      homeConfigurations.cte = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
}
