{ config, lib, ... }:
let
  cfg = config.features.services.gamemode;
  isNvidia = config.features.hardware.nvidia.enable or false;
in
{
  options.features.services.gamemode = {
    enable = lib.mkEnableOption "Feral GameMode (System optimizations for gaming)";
  };

  config = lib.mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
      enableRenice = true; # Allow gamemode to change process priority

      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };

        # Automatically toggle PowerMizer modes if Nvidia is present
        gpu = lib.mkIf isNvidia {
          apply_gpu_optimizations = "accept-responsibility";
          gpu_vendor = "nvidia";
          nv_powermizer_mode = 1; # Prefer Maximum Performance
        };
      };
    };

    users.users.${config.spec.user}.extraGroups = [ "gamemode" ];
  };
}
