{ config, lib, pkgs, ... }:

{
  imports = 
    (import ./modules/editors) ++
    (import ./modules/programs) ++
    (import ./modules/services) ++
    (import ./modules/shells) ++
    (import ./modules/terminals);

  nixpkgs.config.allowUnfree = true;

  home = {
    packages = with pkgs; [
      # Terminal Utils
      btop              # System Resources
      nitch             # Minimal Fetch
      ripgrep           # Grep but Rust
      fd                # Alternative to find

      # Video/Audio
      feh               # Image Viewer
      pavucontrol       # Sound Control GUI

      # File Management
      unzip
      ranger            # Terminal File Manager

      # Apps
      discord
      firefox           # Browser
      zoom-us           # Video Conferencing
      portfolio         # Portfolio Performance
      thunderbird       # Email
      zathura           # PDF Viewer
      gimp

      # Dev stuff
      gh                # GitHub CLI
      rustup            # Rust Utility
      android-studio    # Android Studio
      tectonic          # TeX Engine
      tree-sitter
      rust-analyzer     # Rust LSP
      texlab            # TeX LSP

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

    stateVersion = "22.11";
  };
}
