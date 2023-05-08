{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Odin language
    customPkgs.odin

    # https://github.com/DanielGavin/ols
    customPkgs.ols
  ];
}
