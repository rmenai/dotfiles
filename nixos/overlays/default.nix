{inputs, ...}: let
  additions = final: prev: (prev.lib.packagesFromDirectoryRecursive {
    callPackage = prev.lib.callPackageWith final;
    directory = ../pkgs;
  });

  modifications = final: prev: {
    flameshot = prev.flameshot.overrideAttrs (oldAttrs: {
      pname = "flameshot";
      version = "12.1.0-unstable-2025-06-28";

      src = prev.fetchFromGitHub {
        owner = "flameshot-org";
        repo = "flameshot";
        rev = "56019019999defbf722f43f87aaeae6596a12c0a";
        hash = "sha256-B/piB8hcZR11vnzvue/1eR+SFviTSGJoek1w4abqsek=";
      };

      cmakeFlags =
        (oldAttrs.cmakeFlags or [])
        ++ [
          "-DUSE_WAYLAND_GRIM=ON"
          "-DUSE_WAYLAND_CLIPBOARD=true"
        ];

      patches = [
        # https://github.com/flameshot-org/flameshot/pull/3166
        # fixes fractional scaling calculations on wayland
        (prev.fetchpatch {
          name = "10-fix-wayland.patch";
          url = "https://github.com/flameshot-org/flameshot/commit/5fea9144501f7024344d6f29c480b000b2dcd5a6.patch";
          hash = "sha256-SnjVbFMDKD070vR4vGYrwLw6scZAFaQA4b+MbI+0W9E=";
        })
      ];
    });

    mpv = prev.mpv.override {
      scripts = [final.mpvScripts.mpris];
    };
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
    (additions final prev)
    // (modifications final prev)
    // (stable-packages final prev)
    // (unstable-packages final prev);
}
