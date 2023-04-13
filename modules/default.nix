let
  shared = [
    ./flameshot
    ./gtk
    ./kitty
    ./nvim
    ./picom
    ./rofi
    ./zathura
    ./zsh

    # Languages, Toolchains, ...
    ./rust
    ./tex
    ./zig
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
