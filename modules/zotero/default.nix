{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zotero

    # (zotero.overrideAttrs (p: rec {
    #   # Override zotero desktop file to use default light theme
    #   desktopItem = p.desktopItem.override (d: {
    #     exec = "env GTK_THEME=Default ${d.exec}";
    #   });

    #   # Update install phase to use the new desktop file
    #   installPhase = builtins.replaceStrings [ "${p.desktopItem}" ] [ "${desktopItem}" ] p.installPhase;
    # }))
  ];
}
