{ pkgs, ... }:

{
  gtk-rose-pine-theme = pkgs.callPackage ./gtk-rose-pine-theme {};
  sddm-rose-pine-theme = pkgs.callPackage ./sddm-rose-pine-theme {};
}
