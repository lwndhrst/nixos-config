{ system, pkgs, user, ... }:

let
  modules = import ../../modules;

in {
  imports = with modules; [ 
    fzf
    ghostty
    hypr
    kitty
    neovim
    rclone
    stylix
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
      customPkgs.azahar
      calibre
      firefox
      gimp
      librewolf
      lutris
      obs-studio
      portfolio
      ppsspp-sdl-wayland
      thunderbird
      vlc
      # wineWowPackages.waylandFull # too unstable for now...
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
      lua-language-server
      nil

      # scripts
      customPkgs.scripts.override-rose-pine-colors
    ];

    sessionVariables = {
      EDITOR = "nvim";

      # wayland
      NIXOS_OZONE_WL = 1;
      ANKI_WAYLAND = 1;
    };

    stateVersion = "24.05";
  };
}
