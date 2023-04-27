{ config
, lib
, pkgs
, ... 
}:

let
  modules = import ../../modules;
  packages = import ../../packages { inherit pkgs; };

in {
  imports = with modules; [ ];


  services = { };

  home = {
    packages = with pkgs; [ ];
  };
}
