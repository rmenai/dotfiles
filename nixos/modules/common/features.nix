{ lib, ... }:
{
  options.features = {
    apps = lib.mkOption {
      type = lib.types.submodule { options = { }; };
      default = { };
      description = "Application configurations";
    };

    containers = lib.mkOption {
      type = lib.types.submodule { options = { }; };
      default = { };
      description = "Container configurations";
    };

    core = lib.mkOption {
      type = lib.types.submodule { options = { }; };
      default = { };
      description = "Core system configurations";
    };

    desktop = lib.mkOption {
      type = lib.types.submodule { options = { }; };
      default = { };
      description = "Desktop environment configurations";
    };

    hardware = lib.mkOption {
      type = lib.types.submodule { options = { }; };
      default = { };
      description = "Hardware configurations";
    };

    profiles = lib.mkOption {
      type = lib.types.submodule { options = { }; };
      default = { };
      description = "System profiles";
    };

    services = lib.mkOption {
      type = lib.types.submodule { options = { }; };
      default = { };
      description = "System services";
    };

    users = lib.mkOption {
      type = lib.types.submodule { options = { }; };
      default = { };
      description = "User configurations";
    };
  };
}
