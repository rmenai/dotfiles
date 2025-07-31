{ config, lib, ... }: {
  options.features.services.networking.nullmailer = {
    enable = lib.mkEnableOption "Mail server";
  };

  config = lib.mkIf config.features.services.networking.nullmailer.enable {
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

    features.persist = {
      directories = { "/var/lib/nullmailer" = lib.mkDefault true; };
    };
  };
}
