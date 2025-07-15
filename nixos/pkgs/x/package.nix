{ lib, rustPlatform, }:

rustPlatform.buildRustPackage {
  pname = "x";
  version = "0.1.0";

  src = ./.;
  cargoLock = { lockFile = ./Cargo.lock; };

  meta = {
    description = "Unified command-line tool for Nix system management";
    homepage = "https://github.com/rmenai/dotfiles/tree/main/nixos/pkgs/x";
    license = lib.licenses.mit;
    maintainers = [ "rmenai" ];
  };
}
