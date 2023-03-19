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

      ./desktop/configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.users.${user} = { config, lib, pkgs, ... }: {
          imports = [ ./desktop/home.nix ];
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

      ./laptop/configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.users.${user} = { config, lib, pkgs, ... }: {
          imports = [ ./laptop/home.nix ];
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

      ./vbox/configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.users.${user} = { config, lib, pkgs, ... }: {
          imports = [ ./vbox/home.nix ];
        };
      }
    ];
  };
}
