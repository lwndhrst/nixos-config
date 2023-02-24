{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "sddm-rose-pine-theme";
  version = "1.1";
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/rose-pine
  '';

  src = fetchFromGitHub {
    owner = "leonWindhorst";
    repo = "sddm-rose-pine";
    rev = "${version}";
    sha256 = "HMKBU8/elF4ahpO/xWRIozD3dAnpz52+eFDS3YNDJyw=";
  };
}
