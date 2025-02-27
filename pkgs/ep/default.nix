{
  stdenv,
  lib,
  shellcheck,
  parted,
  btrfs-progs,
  zfs,
  bash,
}:
stdenv.mkDerivation {
  name = "ephemeral-root";
  src = ./src;
  path = lib.makeBinPath ([
    parted
    btrfs-progs
    zfs
  ]);

  nativeCheckInputs = [ shellcheck ];
  buildInputs = [ bash ];
  nativeBuildInputs = [
    parted
    btrfs-progs
    zfs
  ];

  doCheck = true;

  checkPhase = ''
    pushd ./bin
    shellcheck -x ./*
    popd

    pushd ./lib
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
    mkdir -p $out/lib
    cp -r ./ $out/
    chmod -R +x $out/bin/
  '';
}
