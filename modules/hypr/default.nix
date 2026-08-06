{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      hypridle
      hyprpaper
      hyprpicker
      hyprshot
    ];
    
    file.".config/hypr" = {
      source = ./hypr;
      recursive = true;
    };
  };
}
