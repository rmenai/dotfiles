{ config, lib, pkgs, ... }: {
  options.features.apps.tools.bat = {
    enable = lib.mkEnableOption "Bat syntax highlighter";
  };

  config = lib.mkIf config.features.apps.tools.bat.enable {
    programs.bat = {
      enable = true;
      extraPackages = builtins.attrValues {
        inherit (pkgs.bat-extras) batgrep batdiff batman;
      };
    };

    home.activation.batCacheRebuild = {
      after = [ "linkGeneration" ];
      before = [ ];
      data = ''
        ${pkgs.bat}/bin/bat cache --build
      '';
    };

    features.dotfiles = { paths = { ".config/bat" = lib.mkDefault "bat"; }; };
  };
}
