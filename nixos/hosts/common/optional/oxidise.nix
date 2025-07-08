{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    (lib.hiPrio pkgs.uutils-coreutils-noprefix)
    # uutils-diffutils
    # uutils-findutils
  ];
}
