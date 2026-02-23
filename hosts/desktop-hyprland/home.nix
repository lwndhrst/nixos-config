{ pkgs, user, ... }:

let
  modules = import ../../modules;

in {
  imports = with modules; [ 
    fzf
    ghostty
    hypr
    kitty
    neovim
    quickshell
    rclone
    tofi
    wezterm
    zathura
    zotero
    zsh
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # system
      kdePackages.dolphin
      kdePackages.kio
      kdePackages.kio-extras
      kdePackages.qtsvg
      kdePackages.qtwayland
      kdePackages.qt6ct
      pavucontrol
      wl-clipboard

      # apps
      anki-bin
      ausweisapp
      blender
      custom.azahar
      calibre
      firefox
      fontforge-gtk
      gimp3
      librewolf
      lutris
      # stable.meshlab
      obs-studio
      portfolio
      ppsspp-sdl-wayland
      thunderbird
      vlc
      wineWow64Packages.waylandFull
      # wineWow64Packages.stableFull
      # webcord

      # cli
      fd
      git
      git-lfs
      p7zip
      ranger
      ripgrep
      unzip
      wget
      zip

      # dev
      godot
      lua-language-server
      nil
      renderdoc

      # uni
      eduvpn-client

      # scripts
      custom.scripts.override-rose-pine-colors
    ];

    pointerCursor = {
      enable = true;
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 24;
    };

    sessionVariables = {
      EDITOR = "nvim";

      # wayland
      NIXOS_OZONE_WL = 1;
      ANKI_WAYLAND = 1;

      # qt
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };

    stateVersion = "24.05";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  qt = {
    enable = true;
  };
}
