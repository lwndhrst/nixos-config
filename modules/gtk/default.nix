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
      # package = pkgs.gnome.adwaita-icon-theme;
      # name = "Adwaita";

      # package = pkgs.colloid-icon-theme;
      # name = "Colloid-dark";

      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";

      # package = pkgs.vimix-icon-theme;
      # name = "Vimix-dark";

      # package = derivations.rose-pine-icon-theme;
      # name = "rose-pine";
    };

    # font = {
    #   name = "DejaVu Sans";
    # };
  };

  # home.packages = with pkgs; [ derivations.hardcode-tray ];

  home.file = {
    ".config/gtk-4.0" = {
      recursive = true;
      source = "${pkgs.dracula-theme}/share/themes/Dracula/gtk-4.0";
    };

    ".local/share/icons/Papirus-Dark" = {
      source = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
    };

    # ".local/share/icons/Vimix-dark" = {
    #   source = "${pkgs.vimix-icon-theme}/share/icons/Vimix-dark";
    # };
  };
}
