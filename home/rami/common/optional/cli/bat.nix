{pkgs, ...}: {
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
}
