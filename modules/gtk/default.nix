{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };

    iconTheme = {
      package = pkgs.nixExtraPkgs.papirus-icon-theme;
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
