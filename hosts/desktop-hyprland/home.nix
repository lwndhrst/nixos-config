{ pkgs, ... }:

let
  modules = import ../../modules;

in {
  imports = with modules; [ 
    kitty
    neovim
  ];

  home = {
    packages = with pkgs; [
    ];
  };
}

