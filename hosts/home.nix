{ pkgs, user, ... }:

let
  modules  = import ../modules;

in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = with modules; [
    flameshot
    fzf
    gtk 
    kitty
    neovim
    picom
    rofi
    zathura
    zotero
    zsh
  ];

  # For some reason home-manager systray services depend on tray.target
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  services = {
    # Network Manager systray
    network-manager-applet.enable = true;
  };

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    # TODO: holy shit, this is ugly
    packages = with pkgs; [
      htop
      # customPkgs.nitch
      nitch
      ripgrep
      fd
      xclip
      mons
      acpi
      libqalculate
      dconf

      feh
      librsvg
      vlc

      unzip
      ranger

      firefox
      gimp

      nil
      gh
      tree-sitter
      stylua

      openvpn
      networkmanager-openvpn
    ];

    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    sessionVariables = { };

    stateVersion = "22.11";
  };
}
