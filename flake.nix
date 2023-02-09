{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      user = "leon";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit user;
          };

          modules = [ 
            ./configuration.nix 

            home-manager.nixosModules.home-manager {
              home-manager.users.${user} = { config, pkgs, lib, ... }: {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
    };
}
