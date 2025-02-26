{ pkgs,... }:

{
  programs.tofi = {
    enable = true;
    settings = {
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;

      font = "Cascadia Code";
      font-size = 18;
      num-results = 5;

      background-color = "#040e14ee";
      selection-color = "#f6c177";
    };
  };
}
