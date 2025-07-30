{ lib, rustPlatform, }:

rustPlatform.buildRustPackage {
  pname = "wastebin";
  version = "0.1.0";

  src = ./.;
  cargoLock = { lockFile = ./Cargo.lock; };

  meta = {
    description = "Wastebin command-line tool for code sharing";
    homepage =
      "https://github.com/rmenai/dotfiles/tree/main/nixos/pkgs/wastebin";
    license = lib.licenses.mit;
    maintainers = [ "rmenai" ];
  };
}
