{ config, lib, ... }:
let
  nvidiaEnabled = builtins.elem "nvidia" config.services.xserver.videoDrivers;
in
{
  fileSystems."/.swapvol".neededForBoot = true;

  boot = {
    resumeDevice = "/dev/disk/by-uuid/dfe71357-a2e8-479a-b976-0cd1269cbfa2";
    kernelParams = [ "resume_offset=533760" ];

    extraModprobeConfig = lib.mkIf nvidiaEnabled ''
      options nvidia_modeset vblank_sem_control=0 nvidia.NVreg_PreserveVideoMemoryAllocations=1 nvidia.NVreg_TemporaryFilePath=/tmp
    '';
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

  systemd.sleep.settings = {
    Sleep = {
      HibernateDelaySec = "4h";
      SuspendMode = "s2idle";
    };
  };

  security.polkit.enable = true;
}
