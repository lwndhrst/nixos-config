{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings.enable_audio_bell = false;

    font = {
      name = "Cascadia Mono";
      size = 15;
    };

    extraConfig = ''
      include themes/rose-pine-edit.conf
      # include themes/rose-pine.conf

      background_opacity      0.90

      # setting cursor to none makes it use the text color under the cursor
      cursor                  none
      cursor_shape            block
      cursor_blink_interval   0

      disable_ligatures       always

      shell_integration       no-cursor
    '';
  };

  home.file.".config/kitty/themes/rose-pine-edit.conf" = {
    source = ./rose-pine-edit.conf;
  };

  home.file.".config/kitty/themes/rose-pine.conf" = {
    source = ./rose-pine.conf;
  };
}
