{ config
, lib
, pkgs
, ... 
}:

let
  modules  = import ../modules;

in {
  imports = with modules; [
    flameshot
    gtk 
    kitty
    neovim
    picom
    rofi
    zathura
    zotero
    zsh
  ];

  services = {
    # Network Manager systray
    network-manager-applet.enable = true;
  };

  home = {
    packages = with pkgs; [
      # Term Utils
      htop              # System Resources
      customPkgs.nitch  # System Info Fetcher
      ripgrep           # Grep but Rust
      fd                # Alternative find
      xclip             # Access X clipboard from terminal
      mons              # 2-Monitor Setup Script
      acpi              # Battery Status Fetcher
      libqalculate      # Calculator/Equation Solver CLI (qalc)

      # Image/Video/Audio
      feh               # Raster-Image Viewer
      librsvg           # SVG Conversion Utility

      # File Management
      unzip
      ranger            # Terminal File Manager

      # Apps
      firefox           # Browser
      gimp

      # Dev stuff
      gh                # GitHub CLI
      tree-sitter
      stylua
      openvpn
      nil               # Nix Language Server

      # For GTK configuration
      dconf
    ];

    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    sessionVariables = { };

    stateVersion = "22.11";
  };
}
