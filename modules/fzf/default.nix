{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    colors = { 
      "fg" = "#999fa5";
      "bg" = "#000f16";
      "hl" = "#ebbcba";
      "fg+" = "#dbdbdc";
      "bg+" = "#203039";
      "hl+" = "#ebbcba";
      "border" = "#495863";
      "header" = "#31748f";
      "gutter" = "#000f16";
      "spinner" = "#f6c177";
      "info" = "#9ccfd8";
      "separator" = "#495863";
      "pointer" = "#c4a7e7";
      "marker" = "#eb6f92";
      "prompt" = "#999fa5";
    };
  };
}
