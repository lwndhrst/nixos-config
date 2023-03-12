{ home, pkgs, ... }:

let
  derivations = import ../../derivations { inherit pkgs; };
in {
  gtk = {
    enable = true;

    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";

      # package = pkgs.colloid-gtk-theme;
      # name = "Colloid-Dark";

      # package = derivations.colloid-gtk-theme;
      # name = "Colloid-Dark-RosePine";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";

      # package = pkgs.colloid-icon-theme;
      # name = "Colloid-dark";

      # package = pkgs.papirus-icon-theme;
      # name = "Papirus-Dark";

      # package = derivations.rose-pine-icon-theme;
      # name = "rose-pine";
    };

    # font = {
    #   name = "DejaVu Sans";
    # };
  };

  home.file.".config/gtk-4.0" = {
    recursive = true;
    source = "${pkgs.dracula-theme}/share/themes/Dracula/gtk-4.0";
    # source = "${derivations.colloid-gtk-theme}/share/themes/Colloid-Dark-RosePine/gtk-4.0";
  };
}
