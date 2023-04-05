{ stdenvNoCC
, fetchzip
, wineWowPackages
, lib
}:

let
  cmd = "path-of-building";
  dataPathWine = "C:\\ProgramData\\PathOfBuilding\\Builds";
  dataPathUnix = "~/.wine/drive_c/ProgramData/PathOfBuilding/Builds";

in stdenvNoCC.mkDerivation rec {
  pname = "path-of-building";
  version = "2.26.3";
  dontBuild = true;

  propagatedBuildInputs = [
    wineWowPackages.stableFull
  ];

  src = fetchzip {
    url = "https://github.com/PathOfBuildingCommunity/PathOfBuilding/releases/download/v${version}/PathOfBuildingCommunity-Portable-${version}.zip";
    sha256 = "17lns0pm1ajk2ndlgahll1jl2gb5n3fx1i83bl2dh9zmhryj2adf";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/etc
    cp -r $src/* $out/etc


    # The build path has to be set to a writeable directory via PoB's Settings.xml. 
    # In this case we use a dir on the wine C:\ drive, which is located at $HOME/.wine/drive_c/.
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
          buildPath=\"${dataPathWine}\\\"
        />
      </PathOfBuilding>
    " > $out/etc/Settings.xml


    # Replace PoB's update script, since the version is controlled by this package.
    # The replacement update script will simply display a notification if a new version is available.
    chmod +w $out/etc/UpdateCheck.lua
    echo '${lib.strings.fileContents ./UpdateCheck.lua}' > $out/etc/UpdateCheck.lua
  

    # Remove PoB's builtin update error message.
    # The messages defined in ./UpdateCheck.lua will be used instead.
    chmod +w $out/etc/Modules/
    chmod +w $out/etc/Modules/Main.lua
    sed -i 's/Update check failed!\\n//g' $out/etc/Modules/Main.lua


    # This is the script that will be added to PATH.
    # It will run PoB via wine and create the data dir on wine's C:\ drive if it doesn't exist yet.
    mkdir -p $out/bin
    echo "\
      ${wineWowPackages.stableFull}/bin/wine $out/etc/Path\ Of\ Building.exe &
      if [ ! -d ${dataPathUnix} ]; then
        mkdir -p ${dataPathUnix}
      fi
    " > $out/bin/${cmd}
    chmod +x $out/bin/${cmd}


    # Add a desktop file for PoB so it can be launched as a desktop app.
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
