# nixos-config

Personal NixOS configuration


## Setup

### Clone the config

```
git clone https://github.com/leonWindhorst/nixos-config /home/<user>/.config/nixos
```

### Copy the hardware configuration into the flake dir

```
cp /etc/nixos/hardware-configuration.nix /home/<user>/.config/nixos/
```

### Fresh installation

```
sudo nixos-install --flake /home/<user>/.config/nixos
```

### Rebuild

```
sudo nixos-rebuild switch --flake /home/<user>/.config/nixos
```

### Update flake from within the flake dir

```
nix flake update
```
