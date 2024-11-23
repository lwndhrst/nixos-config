{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome.gnome-themes-extra;
      name = "Adwaita-dark";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  # Cursor theme is set via home.pointerCursor
  # gtk.cursorTheme = {
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Ice";
  # };

  home.pointerCursor.gtk.enable = true;

  # home.file.".local/share/themes/Lavanda-Dark" = {
  #   recursive = true;
  #   source = ./themes/Lavanda-Dark;
  # };

  qt.style = {
    package = pkgs.adwaita-qt;
    name = "awaita-dark";
  };
}
