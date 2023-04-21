{ lib
, fetchFromGitHub
, llvmPackages
, libllvm
, makeWrapper
, git
, which
, libiconv
}:

let
  inherit (llvmPackages) stdenv;

in stdenv.mkDerivation rec {
  pname = "odin";
  version = "2023-04";
  dontConfigure = true;

  src = fetchFromGitHub {
    owner = "odin-lang";
    repo = "Odin";
    rev = "dev-${version}";
    sha256 = "lpuBANuu7DWcP4/GxWamTzmg87Q1EXw2jR0yh/YBWQI=";
  };

  nativeBuildInputs = [
    makeWrapper
    git
    which
    libllvm
  ];

  buildInputs = lib.optional stdenv.isDarwin libiconv;

  postPatch = ''
    sed -i 's/^GIT_SHA=.*$/GIT_SHA=/' Makefile
    patchShebangs build_odin.sh
  '';

  buildFlags = [
    "release"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp odin $out/bin/odin
    cp -r core $out/bin/core

    wrapProgram $out/bin/odin --prefix PATH : ${lib.makeBinPath (with llvmPackages; [
      bintools
      llvm
      clang
      lld
    ])}
  '';

  meta = with lib; {
    description = "A fast, concise, readable, pragmatic and open sourced programming language";
    homepage = "https://odin-lang.org/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ luc65r ];
    platforms = platforms.x86_64;
  };
}
