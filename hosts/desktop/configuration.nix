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

  # Use grub for dual boot support.
  boot.loader = {
    grub = {
      enable = true;
      configurationLimit = 5;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  # Fixes time issues when dual booting Windows.
  time.hardwareClockInLocalTime = true;

  networking.hostName = "nixos"; # Define your hostname.

  services = {
    xserver = {
      videoDrivers = [ "amdgpu" ];
      displayManager.setupCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr -s 1920x1080 -r 240
      '';
    };

    # Printer stuff
    printing.enable = true;

    # Needed for wireless printer/scanner
    avahi = { 
      enable = true;
      nssmdns4 = true;
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
  };

  programs = {
    steam.enable = true;
  };

  # Virtualisation
  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
  ];

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "libvirtd" ];
  };
}
