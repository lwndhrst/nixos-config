{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [ android-studio ];

    file.".ideavimrc".text = ''
      set visualbell
      set noerrorbells
    '';
  };
}
