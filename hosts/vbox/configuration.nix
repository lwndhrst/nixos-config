{ config
, lib
, pkgs
, nur
, user
, ... 
}:

let
  derivations = import ../../derivations { inherit pkgs; };

in {
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-vbox"; # Define your hostname.
}
