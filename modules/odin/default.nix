{ pkgs, ... }:

let
  packages = import ../../packages { inherit pkgs; };

in {
  home.packages = with pkgs; [
    # Odin language
    packages.odin

    # TODO: Odin LSP
    # https://github.com/DanielGavin/ols
    packages.ols
  ];
}
