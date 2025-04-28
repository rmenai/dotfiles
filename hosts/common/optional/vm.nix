{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # virtualisation.qemu.options = {
  #   options = [
  #     "-device"
  #     "virtio-vga-gl"
  #     "-display"
  #     "sdl,gl=on,show-cursor=off"
  #     "-device"
  #     "virtio-keyboard"
  #   ];
  # };

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
    quickemu
    quickgui
    libvirt
    pciutils
    qemu
    kmod
  ];
}
