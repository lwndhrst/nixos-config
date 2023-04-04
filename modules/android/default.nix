{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [ android-studio ];

    file.".ideavimrc".text = ''
      set relativenumber
      set visualbell
      set noerrorbells
    '';
  };
}
