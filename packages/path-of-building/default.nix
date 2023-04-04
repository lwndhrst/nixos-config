{ stdenvNoCC
, fetchzip
, wineWowPackages
}:

let
  cmd = "path-of-building";
  homePath = "/home/leon";
  buildPathWin = "C:\\ProgramData\\PathOfBuilding\\Builds";
  buildPathUnix = ".wine/drive_c/ProgramData/PathOfBuilding/Builds";

in stdenvNoCC.mkDerivation rec {
  pname = "path-of-building";
  version = "2.26.2";
  dontBuild = true;

  propagatedBuildInputs = [
    wineWowPackages.stableFull
  ];

  src = fetchzip {
    url = "https://github.com/PathOfBuildingCommunity/PathOfBuilding/releases/download/v${version}/PathOfBuildingCommunity-Portable-${version}.zip";
    sha256 = "0m8mb2qrprkg4bykl427gn09dz9x2kinfp4jpfq4l36c6qf6s5hk";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/etc
    cp -r $src/* $out/etc

    # The build path has to be set to a writeable directory. 
    # In this case we use the wine C:\ drive, which is located at $HOME/.wine/drive_c/.
    echo "\
    <?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <PathOfBuilding>
        <Mode mode=\"LIST\">
        </Mode>
        <Accounts lastAccountName=\"Taikutan\" lastRealm=\"PC\">
            <Account accountName=\"Taikutan\"/>
        </Accounts>
        <SharedItems/>
        <Misc 
            betaTest=\"false\" 
            connectionProtocol=\"0\" 
            thousandsSeparator=\",\" 
            showThousandsSeparators=\"true\" 
            slotOnlyTooltips=\"true\" 
            invertSliderScrollDirection=\"false\" 
            showTitlebarName=\"true\" 
            disableDevAutoSave=\"false\" 
            POESESSID=\"\" 
            defaultCharLevel=\"1\" 
            nodePowerTheme=\"RED/BLUE\" 
            buildSortMode=\"EDITED\" 
            showWarnings=\"true\" 
            defaultItemAffixQuality=\"0.5\" 
            defaultGemQuality=\"0\" 
            decimalSeparator=\".\" 
            buildPath=\"${buildPathWin}\\\"
        />
    </PathOfBuilding>
    " > $out/etc/Settings.xml

    mkdir -p $out/bin
    echo "\
    ${wineWowPackages.stableFull}/bin/wine $out/etc/Path\ Of\ Building.exe &

    if [ ! -d ~/${buildPathUnix} ]; then
        mkdir -p ~/${buildPathUnix}
    fi
    " > $out/bin/${cmd}
    chmod +x $out/bin/${cmd}

    mkdir -p $out/share/applications
    echo "\
    [Desktop Entry]
    Encoding=UTF-8
    Version=${version}
    Type=Application
    Terminal=false
    Exec=$out/bin/${cmd}
    Name=Path of Building
    " > $out/share/applications/path-of-building.desktop
  '';
}
