{ system, pkgs, user, ... }:

let
  modules = import ../../modules;

in {
  imports = with modules; [ 
    fzf
    kitty
    neovim
    stylix
    zathura
    zotero
    zsh
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # system
      hypridle
      hyprpanel
      hyprpaper
      hyprshot
      kdePackages.dolphin
      kdePackages.qtsvg
      kdePackages.qtwayland
      pavucontrol
      wl-clipboard
      wofi

      # apps
      anki
      calibre
      firefox
      gimp
      lutris
      obs-studio
      portfolio
      thunderbird
      vlc
      webcord

      # cli
      fd
      git
      git-lfs
      ranger
      ripgrep
      unzip
      wget
      zip

      # dev
      lua-language-server
      nil
      unityhub

      # scripts
      customPkgs.scripts.override-rose-pine-colors
    ];

    # configured via stylix
    # pointerCursor = {
    #   package = pkgs.bibata-cursors;
    #   name = "Bibata-Modern-Ice";
    #   size = 24;
    #   gtk.enable = true;
    # };

    sessionVariables = {
      EDITOR = "nvim";
      NIXOS_OZONE_WL = "1";
    };

    stateVersion = "24.05";
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
}
