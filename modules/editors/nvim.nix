{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      nvim
    ];

    programs.nvim = {
      enable = true;
    };
  };
}
