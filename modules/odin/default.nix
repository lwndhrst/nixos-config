{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Odin language
    nixExtraPkgs.odin

    # TODO: Odin LSP
    # https://github.com/DanielGavin/ols
    nixExtraPkgs.ols
  ];
}
