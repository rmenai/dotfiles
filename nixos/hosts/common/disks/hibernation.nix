{
  fileSystems."/.swapvol".neededForBoot = true;

  boot.extraModprobeConfig = ''
    options nvidia_modeset vblank_sem_control=0 nvidia.NVreg_PreserveVideoMemoryAllocations=1 nvidia.NVreg_TemporaryFilePath=/tmp
  '';

  boot.resumeDevice = "/dev/disk/by-uuid/dfe71357-a2e8-479a-b976-0cd1269cbfa2";
  boot.kernelParams = ["resume_offset=533760"];

  services.logind = {
    powerKey = "hibernate";
    lidSwitch = "suspend-then-hibernate";
    lidSwitchExternalPower = "suspend-then-hibernate";
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
    SuspendMode=s2idle
  '';

  security.polkit.enable = true;
}
