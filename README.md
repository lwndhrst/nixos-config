# nixos-config

Personal NixOS configuration


## Clone the config

```
git clone https://github.com/leonWindhorst/nixos-config /home/<user>/.config/nixos
```

```
# Make sure to copy the hardware configuration into the flake dir
cp /etc/nixos/hardware-configuration.nix /home/<user>/.config/nixos/
```

```nix
# Fresh installation
sudo nixos-install --flake /home/<user>/.config/nixos#<user>
```

```nix
# Rebuild
sudo nixos-rebuild switch --flake /home/<user>/.config/nixos#<user>
```

```nix
# Update flake from within the flake dir
nix flake update
```
