{ lib, ... }: {
  options.spec = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "The username of the host";
    };
    host = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the host";
    };
    runner = lib.mkOption {
      type = lib.types.enum [ "home" "nixos" "colmena" ];
      description = "The runner of the host flake";
    };
    email = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      description = "The email of the user";
    };
    userFullName = lib.mkOption {
      type = lib.types.str;
      description = "The full name of the user";
    };
    handle = lib.mkOption {
      type = lib.types.str;
      description = "The handle of the user (eg: github user)";
    };
    domain = lib.mkOption {
      type = lib.types.str;
      description = "The handle of the user (eg: github user)";
      default = "localhost";
    };
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/Paris";
      description = "System timezone";
    };
    defaultLocale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "Default system locale";
    };
  };
}
