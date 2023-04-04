{ pkgs, ... }:

let
  packages = import ../../packages { inherit pkgs; };

in {
  gtk = {
    enable = true;

    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };

    iconTheme = {
      package = packages.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  home.file = {
    ".config/gtk-4.0" = {
      recursive = true;
      source = "${pkgs.dracula-theme}/share/themes/Dracula/gtk-4.0";
    };
  };
}
