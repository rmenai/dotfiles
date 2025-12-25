{ config, lib, ... }:
let
  cfg = config.features.services.nullmailer;
in
{
  options.features.services.nullmailer = {
    enable = lib.mkEnableOption "Mail server";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."secrets/nullmailer" = {
      owner = "nullmailer";
      group = "nullmailer";
      mode = "0400";
    };

    services.nullmailer = {
      enable = true;
      setSendmail = true;
      remotesFile = config.sops.secrets."secrets/nullmailer".path;
    };
  };
}
