{ config
, lib
, pkgs
, ... 
}:

let
  modules = import ../../modules;
  packages = import ../../packages { inherit pkgs; };

in {
  imports = modules.vbox;

  services = { };

  home = {
    packages = with pkgs; [ ];
  };
}
