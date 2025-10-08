{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
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

  outputs = { nixpkgs, home-manager, custom-nixpkgs, ... }:
    let
      user = "leon";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [];
        overlays = [
          custom-nixpkgs.overlays.default
        ];
      };
      config = pkgs.config;
      hosts = import ./hosts {
        inherit (nixpkgs) lib;
        inherit system nixpkgs pkgs config home-manager user;
      };

    in {
      nixosConfigurations = hosts.nixosConfigurations;
      homeConfigurations  = hosts.homeConfigurations;
    };
}
