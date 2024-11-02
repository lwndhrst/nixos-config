{ lib
, system
, pkgs
, home-manager
, nur
, user
, stylix
, ... 
}:

let
  nixosSystem = { host }: lib.nixosSystem {
    inherit lib pkgs system;

    specialArgs = {
      inherit user;
    };

    modules = [ 
      # Enable NUR repos via config.nur.repos.<...>
      nur.nixosModules.nur

      ./configuration.nix
      host.config

      host.home
    ];
  };

  homeModule = home: { config, pkgs, lib, ... }: {
    imports = [
      home-manager.nixosModules.home-manager {
        home-manager.extraSpecialArgs = {
          inherit pkgs user;
        };

        home-manager.users.${user} = { config, pkgs, lib, ... }: {
          imports = [
            ./home.nix
            home
          ];
        };
      }
    ];
  };

  homeConfiguration = home: home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { inherit user; };
    modules = [
      ./home.nix
      home
    ];
  };

in {
  # nixos-rebuild switch --flake .#<host>
  nixosConfigurations = {
    desktop = nixosSystem {
      host = { 
        config = ./desktop/configuration.nix;
        home = homeModule ./desktop/home.nix;
      };
    };

    desktop-hyprland = lib.nixosSystem {
      inherit lib pkgs system;

      specialArgs = {
        inherit user;
      };

      modules = [ 
        # Enable NUR repos via config.nur.repos.<...>
        nur.nixosModules.nur

        ./desktop-hyprland/configuration.nix

        home-manager.nixosModules.home-manager {
          home-manager.extraSpecialArgs = {
            inherit pkgs user;
          };

          home-manager.users.${user} = { config, pkgs, lib, ... }: {
            imports = [
              stylix.homeManagerModules.stylix
              ./desktop-hyprland/home.nix
            ];
          };
        }
      ];
    };

    laptop = nixosSystem {
      host = { 
        config = ./laptop/configuration.nix;
        home = homeModule ./laptop/home.nix;
      };
    };

    vbox = nixosSystem {
      host = { 
        config = ./vbox/configuration.nix;
        home = homeModule ./vbox/home.nix;
      };
    };
  };

  # for use in other flakes
  nixosModules = {
    desktop = homeModule ./desktop/home.nix;
    laptop = homeModule ./laptop/home.nix;
    vbox = homeModule ./vbox/home.nix;
  };

  # home-manager switch --flake .#<host>
  homeConfigurations = {
    desktop = homeConfiguration ./desktop/home.nix;
    laptop = homeConfiguration ./laptop/home.nix;
    vbox = homeConfiguration ./vbox/home.nix;

    wsl = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit user; };
      modules = [ ./wsl/home.nix ];
    };
  };
}
