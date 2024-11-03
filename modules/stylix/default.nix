{ pkgs, ... }:

{
  stylix = {
    enable = true;

    image = ./wallpaper.png;
    base16Scheme = ./base16-dark-sakura.yaml;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace =  {
        name = "Cascadia Mono";
        package = pkgs.cascadia-code;
      };
    };

    autoEnable = false;
    targets = {
      fzf.enable = true;
      gtk.enable = true;
      kde.enable = true;
      kitty.enable = true;
    };
  };
}
