{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.boot.lanzaboote = {
    enable = lib.mkEnableOption "lanzaboote secure boot";

    pkiBundle = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/sbctl";
      description = "Path to the PKI bundle for secure boot";
    };
  };

  config = lib.mkIf config.features.boot.lanzaboote.enable {
    environment.systemPackages = [ pkgs.sbctl ];

    boot.lanzaboote = {
      enable = true;
      pkiBundle = config.features.boot.lanzaboote.pkiBundle;
      configurationLimit = config.features.boot.configurationLimit;
    };

    boot.loader = {
      efi.canTouchEfiVariables = true;
      timeout = config.features.boot.timeout;
    };

    boot.loader.systemd-boot.enable = lib.mkForce false;
  };
}
