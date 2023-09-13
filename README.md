# Personal NixOS Configuration



## Setup

Available hosts:
- desktop
- laptop
- vbox



### Fresh installation

```
git clone https://github.com/lwndhrst/nixos /mnt/home/<user>/.config/nixos
```

```
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/<user>/.config/nixos/hosts/<host>/
```

```
sudo nixos-install --flake /mnt/home/<user>/.config/nixos#<host>
```



### Rebuild

Make sure to `git add` new files before rebuilding as they will be ignored otherwise.

```
sudo nixos-rebuild switch --flake ~/.config/nixos#<host>
```



### Update flake from within the flake dir

```
nix flake update
```



## Example flake for `nix develop`

Put flake into `path/to/project/flake.nix` and enter dev shell via `nix develop`.

```nix
{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in {
      devShell.${system} = pkgs.mkShell {
        buildInputs = with pkgs; [
          texlive.combined.scheme-full
          texlab
        ];
      };
    };
}
```
