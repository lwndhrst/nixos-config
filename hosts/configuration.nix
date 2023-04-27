{ config
, lib
, pkgs
, nur
, user
, ... 
}:

let
  packages = import ../packages { inherit pkgs; };

in {
  boot = {
    # Use latest available Kernel packages by default.
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    # Use systemd-boot EFI boot loader.
    loader = {
      systemd-boot = { 
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
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

      windowManager.awesome.enable = true;
      displayManager = {
        defaultSession = "none+awesome";
        sddm = {
          enable = true;
          theme = "rose-pine";
          settings = {
            Theme.CursorTheme = "Bibata-Modern-Ice";
          };
        };
      };
    };
  };

  fonts = {
    fonts = with pkgs; [
      # CJK fonts
      source-han-sans
      source-han-serif

      # Icons, emoji, etc.
      font-awesome

      # Nerdfont overrides
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
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

      # NUR packages
      # config.nur.repos.shadowrz.sddm-sugar-candy

      # Cursor theme
      bibata-cursors

      # Custom packages
      packages.sddm-rose-pine-theme
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
