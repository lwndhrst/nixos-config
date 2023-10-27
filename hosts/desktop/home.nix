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
      pavucontrol       # PulseAudio Settings
      pamixer           # PulseAudio Mixer CLI

      discord
      portfolio         # Portfolio Performance
      thunderbird       # Email
      lutris            # Game Platform (Emulation, etc.)
      protontricks      # Winetricks wrapper for proton games

      path-of-building
    ];
  };
}
