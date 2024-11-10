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
      (ags.overrideAttrs (old: {
        buildInputs = old.buildInputs ++ [ pkgs.libdbusmenu-gtk3 ];
      }))
      anki
      discord
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

  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus-Dark";
  };
}
