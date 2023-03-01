{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings.enable_audio_bell = false;
    font = {
      name = "CaskaydiaCove Nerd Font Mono";
      size = 15;
    };
    theme = "Rosé Pine";
    extraConfig = ''
      background            #0c0b11
      background_opacity    0.95
      disable_ligatures     always
    '';
  };
}
