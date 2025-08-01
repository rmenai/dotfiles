{ config, lib, ... }: {
  options.features.services.networking.tandoor = {
    enable = lib.mkEnableOption "Recipes manager";
  };

  config = lib.mkIf config.features.services.networking.tandoor.enable {
    sops.secrets."secrets/tandoor/key" = { };
    sops.secrets."secrets/tandoor/mail_pass" = { };

    services.tandoor-recipes = {
      enable = true;
      address = "0.0.0.0";
      port = 9090;
      extraConfig = {
        SECRET_KEY = config.sops.secrets."secrets/tandoor/key".path;
        EMAIL_HOST_PASSWORD_FILE =
          config.sops.secrets."secrets/tandoor/mail_pass".path;
      };
    };

    features.persist = {
      directories = { "/var/lib/tandoor-recipes" = true; };
    };
  };
}
