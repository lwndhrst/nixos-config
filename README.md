# nixos-config

Personal NixOS configuration


## Setup


### Clone the config

```
git clone https://github.com/leonWindhorst/nixos-config /mnt/home/<user>/.config/nixos
```


### Fresh installation

```
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/<user>/.config/nixos#nixos
```

```
sudo nixos-install --flake /mnt/home/<user>/.config/nixos
```


### Rebuild

Note: Make sure to stage new files if using git before rebuilding as they will
be ignored otherwise.

```
sudo nixos-rebuild switch --flake /home/<user>/.config/nixos
```


### Update flake from within the flake dir

```
nix flake update
```
