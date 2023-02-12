{ pkgs, ... }:

{
  services.picom = {
    enable = true;

    opacityRules = [ "95:class_g = 'kitty'" ];

    settings = {
      corner-radius = 2;
    };
  };
}
