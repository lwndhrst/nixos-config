{ pkgs, ... }:

{
  programs.wezterm = {
    enable = true;

    colorSchemes = {
      "Rose Pine Edit" = {
        ansi = [
          "#102028" "#eb6f92" "#31748f" "#f6c177"
          "#9ccfd8" "#c4a7e7" "#ebbcba" "#c8d4dc"
        ];
        brights = [
          "#506471" "#eb6f92" "#31748f" "#f6c177"
          "#9ccfd8" "#c4a7e7" "#ebbcba" "#c8d4dc"
        ];

        background = "#040e14";
        foreground = "#c8d4dc";

        selection_bg = "#203039";
        selection_fg = "#c8d4dc";

        cursor_bg = "#c8d4dc";
        cursor_border = "#c8d4dc";
        cursor_fg = "#040e14";
      };
    };

    extraConfig = ''
      return {
        font = wezterm.font("Cascadia Mono"),
        font_size = 15.0,

        color_scheme = "Rose Pine Edit",

        enable_tab_bar = false,
        window_background_opacity = 0.90,
        force_reverse_video_cursor = true,
      }
    '';
  };
}
