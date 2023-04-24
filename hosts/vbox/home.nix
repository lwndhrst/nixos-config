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
    tex
  ];


  services = { };

  home = {
    packages = with pkgs; [ ];
  };
}
