{
  stdenvNoCC,
  lib,
  pkgs,
  requireFile,
}:

let
  _version = "3.6";

  shaperbox3-installer = requireFile {
    name = "Cableguys-ShaperBox-3.6-Setup.exe";
    sha256 = "1lb7izlnz187335xawlix3jrnsp60x3kac28x90pf9l7mv6wmhmx";
    url = "https://www.cableguys.com/shaperbox.html";
  };

in
stdenvNoCC.mkDerivation {
  pname = "shaperbox3";
  version = _version;
  src = shaperbox3-installer;
  dontUnpack = true;

  nativeBuildInputs = [
    pkgs.innoextract
  ];

  installPhase = ''
    runHook preInstall

    # Extract the installer using innoextract
    innoextract $src

    mkdir -p $out

    # Copy the VST3 file from the extracted installer
    # Innoextract creates directories with $ in the names
    if [ -f "code\$GetVST3Dir_64/ShaperBox 3.vst3" ]; then
      cp -r "code\$GetVST3Dir_64/ShaperBox 3.vst3" "$out/"
    fi

    # Also copy VST2 if needed (though yabridge primarily uses VST3)
    if [ -f "code\$GetVST2Dir_64/ShaperBox 3.dll" ]; then
      mkdir -p "$out/vst2"
      cp "code\$GetVST2Dir_64/ShaperBox 3.dll" "$out/vst2/"
    fi

    runHook postInstall
  '';

  meta = with lib; {
    description = "ShaperBox 3 - Creative Effects Bundle by Cableguys (via Yabridge)";
    homepage = "https://www.cableguys.com/shaperbox.html";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
