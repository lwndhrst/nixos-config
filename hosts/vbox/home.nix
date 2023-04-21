{ config
, lib
, pkgs
, ... 
}:

let
  modules = import ../../modules;
  packages = import ../../packages { inherit pkgs; };

in {
  imports = with modules; [
    odin
    rust
    tex
    zig
  ];


  services = { };

  home = {
    packages = with pkgs; [ ];
  };
}
