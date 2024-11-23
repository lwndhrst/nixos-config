{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nur = {
      url = "github:nix-community/NUR"; # Nix User Repository
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    custom-nixpkgs = {
      url = "github:lwndhrst/custom-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles-ags = {
      url = "github:lwndhrst/dotfiles-ags/v2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nur, custom-nixpkgs, stylix, dotfiles-ags, ... }:
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
        inherit system nixpkgs pkgs config home-manager nur user stylix dotfiles-ags;
      };

    in {
      nixosConfigurations = hosts.nixosConfigurations;
      homeConfigurations  = hosts.homeConfigurations;
    };
}
