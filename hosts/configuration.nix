{ config
, lib
, pkgs
, nur
, user
, ... 
}:

let
  modules  = import ../modules;

in {
  boot = {
    # Use latest available Kernel packages by default.
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  };

  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services = {
    xserver = {
      enable = true;

      layout = "us";
      xkbOptions = "caps:escape";

      windowManager = {
        awesome.enable = true;
      };

      displayManager = {
        defaultSession = "none+awesome";
        lightdm = import modules.lightdm { inherit user; };
      };
    };
  };

  fonts = {
    packages = with pkgs; [
      cascadia-code

      # CJK fonts
      source-han-sans
      source-han-serif

      # Nerdfont overrides
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
  };

  programs = {
    zsh.enable = true;
  };

  # Set system-wide variables and packages.
  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [
      "/share/zsh"
    ];

    variables = {
      EDITOR = "nvim";
    };

    systemPackages = with pkgs; [
      gcc
      vim
      wget
      git
    ];
  };

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };

    # Enable flakes.
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
