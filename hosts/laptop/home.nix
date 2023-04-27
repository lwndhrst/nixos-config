{ config
, lib
, pkgs
, ... 
}:

let
  modules = import ../../modules;
  packages = import ../../packages { inherit pkgs; };

in {
  imports = with modules; [
    odin
    rust
    zig
  ];

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
