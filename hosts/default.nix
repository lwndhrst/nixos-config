{ lib
, system
, nixpkgs
, pkgs
, config
, home-manager
, nur
, user
, ... 
}:

let
  nixosSystem = { host }: lib.nixosSystem {
    inherit lib pkgs system;

    specialArgs = {
      inherit nixpkgs user;
    };

    modules = [ 
      # Enable NUR repos via config.nur.repos.<...>
      nur.nixosModules.nur

      ./configuration.nix
      host.config

      home-manager.nixosModules.home-manager {
        home-manager.extraSpecialArgs = {
          inherit nixpkgs pkgs;
        };

        home-manager.users.${user} = { config, lib, pkgs, ... }: {
          imports = [
            ./home.nix
            host.home
          ];
        };
      }
    ];
  };

in {
  desktop = nixosSystem {
    host = { 
      config = ./desktop/configuration.nix;
      home = ./desktop/home.nix;
    };
  };

  laptop = nixosSystem {
    host = { 
      config = ./laptop/configuration.nix;
      home = ./laptop/home.nix;
    };
  };

  vbox = nixosSystem {
    host = { 
      config = ./vbox/configuration.nix;
      home = ./vbox/home.nix;
    };
  };
}
