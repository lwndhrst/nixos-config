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
      cursor                #e0def4
      cursor_text_color     #0c0b11
    '';
  };
}
