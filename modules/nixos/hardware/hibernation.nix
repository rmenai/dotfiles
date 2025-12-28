{ config, lib, ... }:
let
  cfg = config.features.hardware.hibernation;
  nvidiaEnabled = config.features.hardware.nvidia.enable or false;
in
{
  options.features.hardware.hibernation = {
    enable = lib.mkEnableOption "Hibernation Support";

    resumeDevice = lib.mkOption {
      type = lib.types.str;
      default = "/dev/disk/by-uuid/dfe71357-a2e8-479a-b976-0cd1269cbfa2";
      description = "Resume device UUID";
    };

    resumeOffset = lib.mkOption {
      type = lib.types.str;
      default = "533760";
      description = "Resume offset for swapfile";
    };

    delaySec = lib.mkOption {
      type = lib.types.str;
      default = "4h";
      description = "Hibernation delay for suspend-then-hibernate";
    };
  };

  config = lib.mkIf cfg.enable {
    fileSystems."/.swapvol".neededForBoot = true;

    boot = {
      extraModprobeConfig = lib.mkIf nvidiaEnabled ''
        options nvidia_modeset vblank_sem_control=0 nvidia.NVreg_PreserveVideoMemoryAllocations=1 nvidia.NVreg_TemporaryFilePath=/tmp
      '';

      resumeDevice = cfg.resumeDevice;
      kernelParams = [ "resume_offset=${cfg.resumeOffset}" ];
    };

    services.logind = {
      settings = {
        Login = {
          HandlePowerKey = "hibernate";
          HandleLidSwitch = "suspend-then-hibernate";
          HandleLidSwitchExternalPower = "suspend-then-hibernate";
        };
      };
    };

    systemd.sleep.extraConfig = ''
      HibernateDelaySec=${cfg.delaySec}
      SuspendMode=s2idle
    '';

    security.polkit.enable = true;
  };
}
