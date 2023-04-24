{ config
, lib
, pkgs
, nur
, user
, ... 
}:

let
  packages = import ../../packages { inherit pkgs; };

in {
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-vbox"; # Define your hostname.

  services = {
    xserver = {
      displayManager.setupCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr -s 1680x1050
      '';
    };
  };
}
