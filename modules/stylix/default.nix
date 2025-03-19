{ pkgs, ... }:

{
  stylix = {
    enable = true;

    image = ./wallpaper.png;
    base16Scheme = ./base16-rose-pine-edit.yaml;
    polarity = "dark";

    cursor = {
      # package = pkgs.bibata-cursors;
      # name = "Bibata-Modern-Ice";
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 24;
    };

    fonts = {
      monospace =  {
        name = "Cascadia Mono";
        package = pkgs.cascadia-code;
      };
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    autoEnable = false;
    targets = {
      gtk = {
        enable = true;
      };
    };
  };
}
