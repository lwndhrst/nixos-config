{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    settings = {
      corner-radius = 8;
      rounded-corners-exclude = [
        "class_g = 'awesome'"
      ];
    };
  };
}
