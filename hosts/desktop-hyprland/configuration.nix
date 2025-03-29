{ config
, lib
, pkgs
, nur
, user
, ... 
}:

let
  modules  = import ../../modules;

in {
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    # Use latest available Kernel packages by default.
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    loader = {
      systemd-boot = { 
        enable = true;
        configurationLimit = 5;

        # Apparently this is not needed even though it's on a different disk?
        # windows = {
        #   "11-home" = {
        #     title = "Windows 11 Home Edition";
        #     efiDeviceHandle = "FS1";
        #   };
        # };

        # edk2-uefi-shell.enable = true;
      };

      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixos";

    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };

    firewall = {
      enable = false;
      # allowedTCPPorts = [ 22 ];
      # allowedTCPPortRanges = [
      #   { from = 21; to = 22; }
      # ];
    };
  };

  services = {
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

    # For connecting USB devices
    # Calibre needs this apparently
    udisks2.enable = true;
  };

  time = {
    timeZone = "Europe/Berlin";

    # For consistency with Windows
    hardwareClockInLocalTime = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-chinese-addons

          # Pinyin input overlay theme
          customPkgs.fcitx5-rose-pine-edit
        ];
      };
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  fonts = {
    packages = with pkgs; [
      cascadia-code

      # CJK fonts
      source-han-sans
      source-han-serif

      # Nerdfonts
      nerd-fonts.symbols-only
    ];
  };

  programs = {
    hyprland.enable = true;
    gamescope.enable = true;
    gamemode.enable = true;
    steam.enable = true;
    zsh.enable = true;
  };

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "libvirtd" ];
  };

  # Set system-wide variables and packages.
  environment = {
    shells = [ pkgs.zsh ];
    pathsToLink = [
      "/share/zsh"
    ];

    systemPackages = with pkgs; [ ];
  };

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };

    # Enable flakes.
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

