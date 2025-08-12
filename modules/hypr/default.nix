{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      hypridle
      hyprpanel
      hyprpaper
      hyprpicker
      hyprshot
    ];
    
    file.".config/hypr" = {
      source = ./hypr;
      recursive = true;
    };

    file.".config/hyprpanel" = {
      source = ./hyprpanel;
      recursive = true;
    };
  };
}
