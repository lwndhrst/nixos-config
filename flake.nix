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

    nur = {
      url = "github:nix-community/NUR"; # Nix User Repository
    };

    nix-neovim-plugins = {
      url = "github:NixNeovim/NixNeovimPlugins";
    };

    custom-nixpkgs = {
      url = "github:lwndhrst/custom-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-config = {
      url = "github:lwndhrst/home-manager-config/refactor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, home-manager-config, nur, nix-neovim-plugins, custom-nixpkgs, ... }:
    let
      user = "leon";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nix-neovim-plugins.overlays.default
          custom-nixpkgs.overlays.default
        ];
      };
      config = pkgs.config;

    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit system nixpkgs pkgs config home-manager home-manager-config nur user;
        }
      );
    };
}
