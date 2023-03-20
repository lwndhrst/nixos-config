let
  shared = [
    ./flameshot
    ./gtk
    ./kitty
    ./nvim
    ./picom
    ./rofi
    ./tex
    ./zsh
  ];

in {
  desktop = shared ++ [
    ./android
  ];

  laptop = shared ++ [
    ./android
  ];

  vbox = shared ++ [ ];
}
