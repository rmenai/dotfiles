{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  services.spice-vdagentd.enable = true;

  boot.kernelModules = ["kvm-intel" "vfio-pci"];
  boot.kernelParams = ["intel_iommu=on" "iommu=pt"];

  environment.sessionVariables = {
    VAGRANT_DEFAULT_PROVIDER = "libvirt";
  };

  environment.persistence."/persist/system" = {
    directories = [
      "/var/lib/libvirt"
    ];
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    libvirt
    qemu
    spice-protocol
    spice-gtk

    pciutils
    kmod
    davfs2

    quickemu
    quickgui
    vagrant
  ];
}
