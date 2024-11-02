{ pkgs, user, ... }:

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
      ags
      anki
      fd
      firefox
      git
      hyprpaper
      kdePackages.dolphin
      kdePackages.qtsvg
      kdePackages.qtwayland
      lua-language-server
      lutris
      nil
      pavucontrol
      ranger
      ripgrep
      thunderbird
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
    };

    stateVersion = "24.05";
  };
}
