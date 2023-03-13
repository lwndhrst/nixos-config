{ pkgs, ... }:

{
  colloid-gtk-theme = pkgs.callPackage ./colloid-gtk-theme { tweaks = [ "rose_pine" ]; };
  hardcode-tray = pkgs.callPackage ./hardcode-tray {};
  rose-pine-icon-theme = pkgs.callPackage ./rose-pine-icon-theme {};
  sddm-rose-pine-theme = pkgs.callPackage ./sddm-rose-pine-theme {};
}
