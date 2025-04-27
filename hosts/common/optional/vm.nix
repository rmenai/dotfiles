{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;

  boot.kernelModules = ["kvm-intel" "vfio-pci"];
  boot.kernelParams = ["intel_iommu=on" "iommu=pt"];

  environment.systemPackages = with pkgs; [
    virt-manager
    quickemu
    quickgui
    libvirt
    pciutils
    qemu
    kmod
  ];
}
