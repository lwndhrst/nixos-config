{ config
, lib
, pkgs
, nur
, user
, ... 
}:

{
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # VirtualBox Guest Additions like to die in combination with newer kernels than they are meant for...
  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "nixos-vbox"; # Define your hostname.

  services = {
    xserver = {
      displayManager.setupCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr -s 1680x1050
      '';
    };
  };
}
