{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nur = {
      url = "github:nix-community/NUR"; # Nix User Repository
    };

    custom-nixpkgs = {
      url = "github:lwndhrst/custom-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nur, custom-nixpkgs, ... }:
    let
      user = "leon";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [ 
          "zotero-6.0.27" 
        ];
        overlays = [
          custom-nixpkgs.overlays.default
        ];
      };
      config = pkgs.config;
      hosts = import ./hosts {
        inherit (nixpkgs) lib;
        inherit system nixpkgs pkgs config home-manager nur user;
      };

    in {
      nixosConfigurations = hosts.nixosConfigurations;
      nixosModules        = hosts.nixosModules;
      homeConfigurations  = hosts.homeConfigurations;
    };
}
