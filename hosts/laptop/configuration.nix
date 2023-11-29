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

  # Use systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot = { 
      enable = true;
      configurationLimit = 5;
    };
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos-laptop"; # Define your hostname.

  services = {
    xserver = {
      videoDrivers = [ "intel" ];

      # Enable touchpad support (enabled default in most desktopManager).
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };
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

  virtualisation.docker.enable = true;
  networking.firewall.trustedInterfaces = [ "docker0" ];

  programs = {
    steam.enable = true;
  };

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ];
  };
}
