{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tectonic    # TeX Engine
    texlab      # TeX LSP
  ];
}
