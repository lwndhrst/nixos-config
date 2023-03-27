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
  nixosSystem = { hostConfig }: lib.nixosSystem {
    inherit lib pkgs system;

    specialArgs = {
      inherit nixpkgs user;
    };

    modules = [ 
      # Enable NUR repos via config.nur.repos.<...>
      nur.nixosModules.nur

      ./configuration.nix
      hostConfig.system

      home-manager.nixosModules.home-manager {
        home-manager.users.${user} = { config, lib, pkgs, ... }: {
          imports = [
            ./home.nix
            hostConfig.home
          ];
        };
      }
    ];
  };

in {
  desktop = nixosSystem {
    hostConfig = { 
      system = ./desktop/configuration.nix;
      home = ./desktop/home.nix;
    };
  };

  laptop = nixosSystem {
    hostConfig = { 
      system = ./laptop/configuration.nix;
      home = ./laptop/home.nix;
    };
  };

  vbox = nixosSystem {
    hostConfig = { 
      system = ./vbox/configuration.nix;
      home = ./vbox/home.nix;
    };
  };
}
