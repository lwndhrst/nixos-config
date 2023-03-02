{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tectonic    # TeX Engine
    texlab      # TeX LSP
  ];

  # Only basic TeX Live packages such as e.g. bibtex
  programs.texlive = {
    enable = true;
  };
}
