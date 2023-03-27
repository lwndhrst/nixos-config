# nixos-config


## Setup

Available hosts:
- desktop
- laptop
- vbox


### Fresh installation

```
git clone https://github.com/lwndhrst/nixos-config /mnt/home/<user>/.config/nixos
```

```
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/<user>/.config/nixos/hosts/<host>/
```

```
sudo nixos-install --flake /mnt/home/<user>/.config/nixos#<host>
```


### Rebuild

Make sure to <code>git add</code> new files before rebuilding as they will be ignored otherwise.

```
sudo nixos-rebuild switch --flake ~/.config/nixos#<host>
```


### Update flake from within the flake dir

```
nix flake update
```
