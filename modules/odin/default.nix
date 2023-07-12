{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # customPkgs.odin
    odin-dev

    # customPkgs.ols
    ols
  ];
}
