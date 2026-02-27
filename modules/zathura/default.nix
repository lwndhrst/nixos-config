{ pkgs, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard     = "clipboard";

      recolor                 = "true";
      recolor-keephue         = "false";

      default-bg              = "#040e14";
      default-fg              = "#c8d4dc";
      statusbar-bg            = "#102028";
      statusbar-fg            = "#c8d4dc";
      inputbar-bg             = "#102028";
      inputbar-fg             = "#ebbcba";
      notification-bg         = "#c8d4dc";
      notification-fg         = "#040e14";
      notification-error-bg   = "#f6c177";
      notification-error-fg   = "#040e14";
      notification-warning-bg = "#ebbcba";
      notification-warning-fg = "#040e14";
      completion-bg           = "#102028";
      completion-fg           = "#ebbcba";
      completion-highlight-bg = "#ebbcba";
      completion-highlight-fg = "#102028";
      recolor-lightcolor      = "#0a161d";
      recolor-darkcolor       = "#c8d4dc";
    };
  };
}
