# NixOS Configuration

### Getting Started

Add channels:

```sh
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
sudo nix-channel --update

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

Clone repo and add hardware configuration:

```sh
nix-shell -p git
git clone https://github.com/cte/dotfiles.git
cd dotfiles
cp /etc/nixos/hardware-configuration.nix ./hosts/dusk
git add .
exit
```

Alternatively, you can can create a new host configuration using the example set by `dusk`.

Rebuild:

```sh
cd ~/dotfiles
sudo nixos-rebuild switch --flake .#dusk
```

Reboot:

```sh
sudo reboot
```

Symlink dotfiles:

```sh
cd ~/dotfiles/config
./install.sh
```

### Resources

#### Documentation
- https://wiki.nixos.org/wiki/GNOME
- https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/#declaratively-configuring-gnome
- https://github.com/mitchellh/nixos-config
- https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505/11
- https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager
- https://github.com/ryan4yin/nix-config
- https://github.com/Daholli/nixos-config
- https://hyprland.org/hall_of_fame/

#### Videos
- https://www.youtube.com/watch?v=ACybVzRvDhs
- https://www.youtube.com/watch?v=IiyBeR-Guqw
