{ pkgs, user, ... }:

let
  modules = import ../../modules;

in {
  imports = with modules; [ 
    fzf
    ghostty
    hypr
    gtk
    kitty
    neovim
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
      kdePackages.qtsvg
      kdePackages.qtwayland
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
      stable.meshlab
      obs-studio
      portfolio
      ppsspp-sdl-wayland
      thunderbird
      vlc
      # wineWowPackages.waylandFull # too cooked for now...
      wineWowPackages.stableFull
      webcord

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
    };

    stateVersion = "24.05";
  };
}
