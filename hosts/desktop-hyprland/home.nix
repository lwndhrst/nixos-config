{ pkgs, user, ... }:

let
  modules = import ../../modules;

in {
  imports = with modules; [ 
    fzf
    kitty
    neovim
    zathura
    zotero
    zsh
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      git
      ripgrep
      fd
      nil
      firefox
      pavucontrol
      wofi
      waybar
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    stateVersion = "24.05";
  };
}

