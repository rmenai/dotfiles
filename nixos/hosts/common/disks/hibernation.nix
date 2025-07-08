{
  fileSystems."/.swapvol".neededForBoot = true;

  boot.resumeDevice = "/dev/disk/by-uuid/dfe71357-a2e8-479a-b976-0cd1269cbfa2";
  boot.kernelParams = [
    "mem_sleep_default=deep"
    "resume_offset=533760"
  ];

  systemd.sleep.extraConfig = ''
    [Sleep]
    HibernateDelaySec=1h
  '';

  services.logind.lidSwitch = "suspend-then-hibernate";
  security.polkit.enable = true;
}
