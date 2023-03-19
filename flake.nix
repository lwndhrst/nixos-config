{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR"; # Nix User Repository
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, ... }:
    let
      user = "leon";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;

    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user;
        }
      );
    };
}
