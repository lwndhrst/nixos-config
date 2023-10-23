{ lib
, system
, nixpkgs
, pkgs
, home-manager-config
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

      # Home config from home-manager-config flake
      host.home
    ];
  };

in {
  desktop = nixosSystem {
    host = { 
      config = ./desktop/configuration.nix;
      home = home-manager-config.nixosModules.desktop;
    };
  };

  laptop = nixosSystem {
    host = { 
      config = ./laptop/configuration.nix;
      home = home-manager-config.nixosModules.laptop;
    };
  };

  vbox = nixosSystem {
    host = { 
      config = ./vbox/configuration.nix;
      home = home-manager-config.nixosModules.vbox;
    };
  };
}
