# NixOS Configuration

### Getting Started

Clone repo:

```sh
nix-shell -p git --command "git clone https://github.com/cte/dotfiles.git"
```

Rebuild system:

```sh
cd ~/dotfiles
cp /etc/nixos/hardware-configuration.nix .
nix-shell -p git --command "git add hardware-configuration.nix"
sudo nixos-rebuild switch --flake .#dusk
```

Install Home Manager:

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

Rebuild home:

```sh
home-manager switch --flake .
```

Reboot:

```sh
sudo reboot
```

### Resources

#### Documentation
- https://wiki.nixos.org/wiki/GNOME
- https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/#declaratively-configuring-gnome
- https://github.com/mitchellh/nixos-config
- https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505/11

#### Videos
- https://www.youtube.com/watch?v=ACybVzRvDhs
- https://www.youtube.com/watch?v=IiyBeR-Guqw
