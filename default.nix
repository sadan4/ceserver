{
  stdenv,
  glibc,
  zlib,
  fetchFromGitHub,
  lib,
  gnumake,
}:
stdenv.mkDerivation rec {
  pname = "ceserver";
  name = pname;
  src = fetchFromGitHub {
    owner = "cheat-engine";
    repo = "cheat-engine";
    rev = "e137317cbe9692c4dc61e6d2e89bf543b4d7301f";
    hash = "sha256-kEpt4cspC5BR+03022cPnOpNLxAUbUpdEM+K9wcv1Mo=";
  };
  buildInputs = [
    glibc
    zlib
    stdenv
  ];
  nativeBuildInputs = [
    gnumake
  ];
  buildPhase = ''
    runHook preBuild

    pushd Cheat\ Engine/ceserver/gcc

    make

    popd

    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    ls
    cp Cheat\ Engine/ceserver/gcc/ceserver $out/bin/ceserver

    runHook postInstall
  '';
  meta = {
    license = lib.licenses.unfree;
    description = "Cheat engine server";
    mainProgram = "ceserver";
  };
}
