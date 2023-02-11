{ config, lib, pkgs, ... }:

{
  imports = 
    (import ./modules/editors) ++
    (import ./modules/programs) ++
    (import ./modules/services) ++
    (import ./modules/shells) ++
    (import ./modules/terminals);

  home = {
    packages = with pkgs; [
      # TUI
      btop              # System Resources
      nitch             # Minimal Fetch

      # Video/Audio
      feh               # Image Viewer

      # Apps
      firefox

      # File Management
      unzip
    ];

    stateVersion = "22.11";
  };
}
