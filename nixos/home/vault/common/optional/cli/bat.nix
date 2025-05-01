{
  pkgs,
  lib,
  ...
}: {
  programs.bat = {
    enable = true;
    extraPackages = builtins.attrValues {
      inherit
        (pkgs.bat-extras)
        batgrep
        batdiff
        batman
        ;
    };
  };

  home.activation.batCacheRebuild = {
    after = ["linkGeneration"];
    before = [];
    data = ''
      ${pkgs.bat}/bin/bat cache --build
    '';
  };

  dotfiles = {
    files = {
      ".config/bat" = lib.mkDefault "bat";
    };
  };

  persist = {
    home = {
      ".cache/bat" = lib.mkDefault true;
    };
  };
}
