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
      anki
      discord
      calibre
      fd
      firefox
      gimp
      git
      hypridle
      hyprpaper
      hyprshot
      kdePackages.dolphin
      kdePackages.qtsvg
      kdePackages.qtwayland
      lua-language-server
      lutris
      nil
      pavucontrol
      portfolio
      ranger
      ripgrep
      thunderbird
      unzip
      waybar
      wget
      wofi
    ];

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
