# nixos-config

Personal NixOS configuration


## Setup

Available hosts:
- desktop
- laptop
- vbox


### Fresh installation

```
git clone https://github.com/leonWindhorst/nixos-config /mnt/home/<user>/.config/nixos
```

```
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/<user>/.config/nixos/hosts/<host>/
```

```
sudo nixos-install --flake /mnt/home/<user>/.config/nixos#<host>
```


### Rebuild

Note: Make sure to stage new files if using git before rebuilding as they will
be ignored otherwise.

```
sudo nixos-rebuild switch --flake ~/.config/nixos#<host>
```


### Update flake from within the flake dir

```
nix flake update
```
