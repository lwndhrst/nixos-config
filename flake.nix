{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    custom-nixpkgs = {
      url = "github:lwndhrst/custom-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, custom-nixpkgs, ... }:
    let
      user = "leon";
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          custom-nixpkgs.overlays.default

          (_: _: {
            stable = import nixpkgs-stable {
              inherit system config;
            };
          })
        ];
      };

      config = pkgs.config;
      
      hosts = import ./hosts {
        inherit (nixpkgs) lib;
        inherit system pkgs config home-manager user;
      };

    in {
      nixosConfigurations = hosts.nixosConfigurations;
      homeConfigurations  = hosts.homeConfigurations;
    };
}
