# nixos-config

Personal NixOS configuration



## Enable flakes in configuration.nix

```
nix = {
  package = pkgs.nixFlakes;
  extraOptions = "experimental-features = nix-command flakes";
};
```
```
sudo nixos-rebuild switch
```

## Clone config
```
git clone https://github.com/leonWindhorst/nixos-config ~/flake
```
```
sudo nixos-rebuild switch --flake ~/flake#<user>
```
