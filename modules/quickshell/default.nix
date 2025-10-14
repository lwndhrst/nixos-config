{ pkgs, ... }:

{
  programs.quickshell = {
    enable = true;
  };

  home = {
    packages = with pkgs; [
      # qmlls and other qml tools
      kdePackages.qtdeclarative
    ];

    file.".config/quickshell" = {
      source = ./quickshell;
      recursive = true;
    };
  };
}
