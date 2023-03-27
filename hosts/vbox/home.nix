{ config
, lib
, pkgs
, ... 
}:

let
  derivations = import ../../derivations { inherit pkgs; };
  modules = import ../../modules;

in {
  imports = modules.vbox;

  nixpkgs.config.allowUnfree = true;

  services = { };

  home = {
    packages = with pkgs; [ ];
  };
}
