# NixOS Configuration

### Getting Started

Create SSH keypair:

```sh
ssh-keygen -trsa
cat .ssh/id_rsa.pub
```

Upload SSH key to Github:

# TODO

Clone dotfiles repo:

```sh
git clone git@github.com:cte/dotfiles.git
```

Rebuild system:

```sh
cd ~/dotfiles
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

### Resources

#### Documentation
- https://wiki.nixos.org/wiki/GNOME
- https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/#declaratively-configuring-gnome

#### Videos
- https://www.youtube.com/watch?v=ACybVzRvDhs
- https://www.youtube.com/watch?v=IiyBeR-Guqw
