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

  boot = {
    # VirtualBox Guest Additions like to die in combination with newer kernels than they are meant for...
    kernelPackages = pkgs.linuxPackages;

    # Use systemd-boot EFI boot loader.
    loader = {
      systemd-boot = { 
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "nixos-vbox"; # Define your hostname.

  services = {
    xserver = {
      displayManager.setupCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr -s 1680x1050
      '';
    };
  };

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };
}
