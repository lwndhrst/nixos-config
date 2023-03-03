{ home, pkgs, ... }:

let
  derivations = import ../../derivations { inherit pkgs; };
in {
  gtk = {
    enable = true;

    theme = {
      # package = pkgs.colloid-gtk-theme;
      # name = "Colloid-Dark";

      # package = pkgs.dracula-theme;
      # name = "Dracula";

      package = derivations.colloid-gtk-theme;
      name = "Colloid-Dark-RosePine";
    };

    iconTheme = {
      # package = pkgs.colloid-icon-theme;
      # name = "Colloid-dark";

      # package = pkgs.papirus-icon-theme;
      # name = "Papirus-Dark";

      package = derivations.rose-pine-icon-theme;
      name = "rose-pine";
    };

    # font = {
    #   name = "DejaVu Sans";
    # };
  };
}
