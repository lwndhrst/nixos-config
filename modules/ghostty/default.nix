{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    themes = {
      rose-pine-edit = {
        background = "#040e14";
        foreground = "#c8d4dc";

        selection-background = "#203039";
        selection-foreground = "#c8d4dc";

        cursor-color = "#c8d4dc";
        cursor-text = "#040e14";

        palette = [
          "0=#102028"
          "1=#eb6f92"
          "2=#31748f"
          "3=#f6c177"
          "4=#9ccfd8"
          "5=#c4a7e7"
          "6=#ebbcba"
          "7=#c8d4dc"

          "8=#506471"
          "9=#eb6f92"
          "10=#31748f"
          "11=#f6c177"
          "12=#9ccfd8"
          "13=#c4a7e7"
          "14=#ebbcba"
          "15=#c8d4dc"
        ];
      };
    };

    settings = {
      theme = "rose-pine-edit";

      font-family = "Cascadia Mono";
      font-size = 15;

      background-opacity = 0.9;
      window-padding-balance = true;

      cursor-invert-fg-bg = true;

      keybind = [ ];
    };
  };
}
