{ inputs, ... }:
let
  additions = final: prev:
    (prev.lib.packagesFromDirectoryRecursive {
      callPackage = prev.lib.callPackageWith final;
      directory = ../pkgs;
    });

  modifications = final: prev: {
    mpv = prev.mpv.override { scripts = [ final.mpvScripts.mpris ]; };
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
in {
  default = final: prev:
    (additions final prev) // (modifications final prev)
    // (stable-packages final prev) // (unstable-packages final prev);
}
