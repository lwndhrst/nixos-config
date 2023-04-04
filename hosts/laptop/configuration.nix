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

  networking.hostName = "nixos-laptop"; # Define your hostname.

  services = {
    # Enable touchpad support (enabled default in most desktopManager).
    xserver.libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    # Printer stuff
    printing.enable = true;

    # Needed for wireless printer/scanner
    avahi = { 
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };

    # Sound
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    # Daemon for controlling brightness with brightness buttons
    illum.enable = true;

    # Rebind power button to suspend
    logind = {
      extraConfig = ''
        # suspend when power button is pressed
        HandlePowerKey=suspend
      '';
    };
  };
}
