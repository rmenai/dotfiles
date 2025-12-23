{ config, lib, ... }:
{
  options.features.hibernation = {
    enable = lib.mkEnableOption "hibernation support";

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
      default = "1h";
      description = "Hibernation delay for suspend-then-hibernate";
    };
  };

  config = lib.mkIf config.features.hibernation.enable {
    fileSystems."/.swapvol".neededForBoot = true;

    boot.extraModprobeConfig = lib.mkIf config.features.hardware.nvidia.enable ''
      options nvidia_modeset vblank_sem_control=0 nvidia.NVreg_PreserveVideoMemoryAllocations=1 nvidia.NVreg_TemporaryFilePath=/tmp
    '';

    boot.resumeDevice = config.features.hibernation.resumeDevice;
    boot.kernelParams = [ "resume_offset=${config.features.hibernation.resumeOffset}" ];

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
      HibernateDelaySec=${config.features.hibernation.delaySec}
      SuspendMode=s2idle
    '';

    security.polkit.enable = true;
  };
}
