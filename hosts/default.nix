{ lib
, system
, nixpkgs
, pkgs
, config
, home-manager-config
, nur
, user
, ... 
}:

let
  home-manager-modules = home-manager-config.nixosModules { inherit config; };
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
      host.home
    ];
  };

in {
  desktop = nixosSystem {
    host = { 
      config = ./desktop/configuration.nix;
      home = home-manager-modules.desktop;
    };
  };

  laptop = nixosSystem {
    host = { 
      config = ./laptop/configuration.nix;
      home = home-manager-modules.laptop;
    };
  };

  vbox = nixosSystem {
    host = { 
      config = ./vbox/configuration.nix;
      home = home-manager-modules.vbox;
    };
  };
}
