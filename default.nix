(pkgs: prev: {
  ceserver = pkgs.callPackage (
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
        rev = "59930b596dabbd83e37191e4a58e72f09a9beb75";
        hash = "sha256-J2WyNB5MUqcTUc7JjUIq/EBrBHFqxT3LeaUumWorg/4=";
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
  ) { };
})
