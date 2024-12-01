{ system, pkgs, user, dotfiles-ags, ... }:

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
      dotfiles-ags.packages.${system}.default
      dotfiles-ags.packages.${system}.launcher
      hypridle
      hyprpaper
      hyprshot
      kdePackages.dolphin
      kdePackages.qtsvg
      kdePackages.qtwayland
      pavucontrol

      # apps
      anki
      calibre
      firefox
      gimp
      lutris
      obs-studio
      portfolio
      thunderbird
      webcord

      # cli
      fd
      git
      ranger
      ripgrep
      unzip
      wget

      # lsp
      lua-language-server
      nil
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
      TERMINAL = "kitty";
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
