{ lib
, system
, pkgs
, config
, home-manager
, nur
, user
, stylix
, ... 
}:

let
  nixosSystem = { hostModules }: lib.nixosSystem {
    inherit lib pkgs system;

    specialArgs = { inherit user; };

    modules = (hostModules.config ++ [ 
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.extraSpecialArgs = { inherit system user; };
        home-manager.users.${user} = {
          imports = hostModules.home;
        };
      }
    ]);
  };

in {
  # nixos-rebuild switch --flake .#<host>
  nixosConfigurations = {
    desktop-hyprland = nixosSystem {
      hostModules = { 
        config = [
          nur.modules.nixos.default
          ./desktop-hyprland/configuration.nix
        ];
        home = [
          stylix.homeManagerModules.stylix
          ./desktop-hyprland/home.nix
        ];
      };
    };
  };

  # home-manager switch --flake .#<host>
  homeConfigurations = {
    wsl = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit user; };
      modules = [ ./wsl/home.nix ];
    };
  };
}
