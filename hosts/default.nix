{ lib
, inputs
, nixpkgs
, home-manager
, nur
, user
, ... 
}:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;

in {
  desktop = lib.nixosSystem {
    inherit lib pkgs system;

    specialArgs = {
      inherit nixpkgs user;
    };

    modules = [ 
      # Enable NUR repos via config.nur.repos.<...>
      nur.nixosModules.nur

      ./configuration.nix
      ./desktop/configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.users.${user} = { config, lib, pkgs, ... }: {
          imports = [
            ./home.nix
            ./desktop/home.nix
          ];
        };
      }
    ];
  };

  laptop = lib.nixosSystem {
    inherit lib pkgs system;

    specialArgs = {
      inherit nixpkgs user;
    };

    modules = [ 
      # Enable NUR repos via config.nur.repos.<...>
      nur.nixosModules.nur

      ./configuration.nix
      ./laptop/configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.users.${user} = { config, lib, pkgs, ... }: {
          imports = [
            ./home.nix
            ./laptop/home.nix
          ];
        };
      }
    ];
  };

  vbox = lib.nixosSystem {
    inherit lib pkgs system;

    specialArgs = {
      inherit nixpkgs user;
    };

    modules = [ 
      # Enable NUR repos via config.nur.repos.<...>
      nur.nixosModules.nur

      ./configuration.nix
      ./vbox/configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.users.${user} = { config, lib, pkgs, ... }: {
          imports = [
            ./home.nix
            ./vbox/home.nix
          ];
        };
      }
    ];
  };
}
