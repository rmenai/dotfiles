{
  fileSystems."/.swapvol".neededForBoot = true;

  boot.extraModprobeConfig = ''
    options nvidia_modeset vblank_sem_control=0
  '';

  boot.resumeDevice = "/dev/disk/by-uuid/dfe71357-a2e8-479a-b976-0cd1269cbfa2";
  boot.kernelParams = [
    "mem_sleep_default=deep"
    "resume_offset=533760"
  ];

  services.logind = {
    powerKey = "hibernate";
    lidSwitch = "suspend";
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
  '';

  security.polkit.enable = true;
}
