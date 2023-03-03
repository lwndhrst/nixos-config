{ stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation rec {
  pname = "sddm-rose-pine-theme";
  version = "1.2";
  dontBuild = true;

  src = fetchFromGitHub {
    owner = "leonWindhorst";
    repo = "sddm-rose-pine";
    rev = "v${version}";
    sha256 = "sHIeck++vUS21OXcUmaKimKSoiTPxzD8ST749QSaAkQ=";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/rose-pine
  '';
}
