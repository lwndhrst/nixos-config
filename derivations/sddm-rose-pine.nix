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
    rev = "main";
    sha256 = "r7NdWdK9DOyHL3/u4Syp4uhRv5JgZ5aU4zUEmBizkXs=";
  };
}
