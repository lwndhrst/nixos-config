{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    
    settings = {
      font = {
        size = 15;
        normal = {
          family = "CaskaydiaCove Nerd Font Mono";
          style = "Regular";
        };
      };

      # rose-pine with darker bg
      colors = {
        primary = {
          background = "#0c0b11";
          foreground = "#e0def4";
        };

        # ...

      };
    };
  };
}
