{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    colors = { 
      "fg" = "#708593";
      "bg" = "#040e14";
      "hl" = "#ebbcba";
      "fg+" = "#c8d4dc";
      "bg+" = "#102028";
      "hl+" = "#ebbcba";
      "border" = "#203039";
      "header" = "#31748f";
      "gutter" = "#040e14";
      "spinner" = "#f6c177";
      "info" = "#9ccfd8";
      "pointer" = "#c4a7e7";
      "marker" = "#eb6f92";
      "prompt" = "#708593";
    };
  };
}
