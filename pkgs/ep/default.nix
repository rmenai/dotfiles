{
  stdenv,
  lib,
  shellcheck,
  btrfs-progs,
  bash,
}:
stdenv.mkDerivation {
  name = "ep";
  src = ./src;
  path = lib.makeBinPath [
    btrfs-progs
  ];

  nativeCheckInputs = [shellcheck];
  buildInputs = [bash];
  nativeBuildInputs = [
    btrfs-progs
  ];

  doCheck = true;

  checkPhase = ''
    pushd ./bin
    shellcheck -x ./*
    popd
  '';

  buildPhase = ''
    for f in **/*
    do
      if [[ -f "$f" ]]; then
        substituteAllInPlace "$f"
      fi
    done
  '';

  installPhase = ''
    mkdir -p $out/bin/
    cp -r ./ $out/
    chmod -R +x $out/bin/
  '';
}
