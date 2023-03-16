{ pkgs, ... }:

let
  derivations = import ../../derivations { inherit pkgs; };

in {
  gtk = {
    enable = true;

    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";

      # package = derivations.colloid-gtk-theme;
      # name = "Colloid-Dark-RosePine";
    };

    iconTheme = {
      package = derivations.papirus-icon-theme;
      name = "Papirus-Dark";

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

    # ".local/share/icons/Papirus-Dark" = {
    #   source = "${derivations.papirus-icon-theme}/share/icons/Papirus-Dark";
    # };

    # ".icons/Papirus-Dark" = {
    #   source = "${derivations.papirus-icon-theme}/share/icons/Papirus-Dark";
    # };
  };
}
