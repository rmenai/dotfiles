{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  services.spice-vdagentd.enable = true;

  boot.kernelModules = ["kvm-intel" "vfio-pci"];
  boot.kernelParams = ["intel_iommu=on" "iommu=pt"];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };

  environment.persistence."/persist/system" = {
    directories = [
      "/var/lib/libvirt"
    ];
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    quickemu
    quickgui
    libvirt
    pciutils
    qemu
    kmod
    davfs2
  ];
}
