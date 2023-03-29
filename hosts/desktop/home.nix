{ config
, lib
, pkgs
, ... 
}:

let
  derivations = import ../../derivations { inherit pkgs; };
  modules = import ../../modules;

in {
  imports = modules.desktop;

  services = {
    # PulseAudio systray
    pasystray.enable = true;
  };

  home = {
    packages = with pkgs; [
      # Video/Audio
      pavucontrol       # PulseAudio Settings
      pamixer           # PulseAudio Mixer CLI

      # Apps
      discord
      zoom-us           # Video Conferencing
      portfolio         # Portfolio Performance
      thunderbird       # Email
    ];
  };
}
