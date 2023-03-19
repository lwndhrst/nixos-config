{ config
, lib
, pkgs
, ... 
}:

let
  derivations = import ../../derivations { inherit pkgs; };

in {
  imports = import ./modules.nix;

  nixpkgs.config.allowUnfree = true;

  services = {
    # Network Manager systray
    network-manager-applet.enable = true;
  };

  home = {
    packages = with pkgs; [
      # Term Utils
      htop              # System Resources
      nitch             # Fetch system info
      ripgrep           # Grep but Rust
      fd                # Alternative to find
      xclip             # Access X clipboard from terminal

      # Video/Audio
      feh               # Raster-Image Viewer
      librsvg           # SVG Conversion Utility
      # pavucontrol       # PulseAudio Settings

      # File Management
      unzip
      ranger            # Terminal File Manager

      # Apps
      # discord
      firefox           # Browser
      # zoom-us           # Video Conferencing
      # portfolio         # Portfolio Performance
      # thunderbird       # Email
      zathura           # PDF Viewer
      gimp
      zotero            # Literature Manager

      # Dev stuff
      gh                # GitHub CLI
      rustup            # Rust Toolchain Utility
      rust-analyzer     # Rust LSP
      tree-sitter
      openvpn

      # For GTK configuration
      dconf

      # Wine for both 32 and 64 bit
      wineWowPackages.stableFull
    ];

    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";

      # package = pkgs.phinger-cursors;
      # name = "phinger-cursors-light";
      
      # package = pkgs.quintom-cursor-theme;
      # name = "Quintom_Snow";

      # package = pkgs.catppuccin-cursors.mochaLight;
      # name = "Catppuccin-Mocha-Light-Cursors";

      # package = pkgs.capitaine-cursors;
      # name = "capitaine-cursors-white";
    };

    sessionVariables = { };

    stateVersion = "22.11";
  };
}
