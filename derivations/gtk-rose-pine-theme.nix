{ stdenv, fetchFromGitHub }:

let 
  themeName = "rose-pine";
in stdenv.mkDerivation rec {
  pname = "gtk-rose-pine-theme";
  version = "2.1.0";
  dontBuild = true;

  src = fetchFromGitHub {
    owner = "rose-pine";
    repo = "gtk";
    rev = "${version}";
    sha256 = "sha256-MT8AeC+uGRZS4zFNvAqxqSLVYpd9h64RdSvr6Ky4HA4=";
  };

  installPhase = ''
    mkdir -p $out/share/themes/${themeName}
    cp -aR $src/gtk3/rose-pine-gtk/* $out/share/themes/${themeName}/

    mkdir -p $out/share/themes/${themeName}/gtk-4.0
    cp -a $src/gtk4/rose-pine.css $out/share/themes/${themeName}/gtk-4.0/gtk.css

    mkdir -p $out/share/icons/${themeName}
    cp -aR $src/icons/rose-pine-dawn-icons/* $out/share/icons/${themeName}/
  '';
}
