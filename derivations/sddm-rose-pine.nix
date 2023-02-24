{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "sddm-rose-pine-theme";
  version = "1.0";
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/rose-pine
  '';

  src = fetchFromGitHub {
    owner = "leonWindhorst";
    repo = "sddm-rose-pine";
    rev = "${version}";
    sha256 = "WBkb2GK5g0/5YfZ6jRnY0WLnH1nIMOM6/HhwUD9YXhM=";
  };
}
