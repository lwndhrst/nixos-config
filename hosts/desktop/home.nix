{ pkgs, ... }:

let
  modules = import ../../modules;

in {
  imports = with modules; [ ];

  services = {
    # PulseAudio systray
    pasystray.enable = true;
  };

  home = {
    packages = with pkgs; [
      pavucontrol
      pamixer

      discord
      portfolio
      thunderbird
      lutris
      protontricks

      path-of-building
    ];
  };
}
