{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = [pkgs.virtiofsd];
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.virtualbox.host = {
    enable = true;
    enableKvm = true;
    enableExtensionPack = true;
    enableHardening = false;
    addNetworkInterface = false;
  };

  virtualisation.waydroid.enable = true;

  services.spice-vdagentd.enable = true;
  programs.virt-manager.enable = true;

  # https://www.rodolfocarvalho.net/blog/resize-disk-vagrant-libvirt/
  boot.kernelModules = ["9p" "9pnet" "9pnet_virtio"];
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  environment.sessionVariables = {
    VAGRANT_DEFAULT_PROVIDER = "libvirt";
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };

  environment.persistence."/persist/system" = {
    directories = [
      "/var/lib/libvirt"
      "/var/lib/waydroid"
      "/etc/vbox"
    ];
  };

  environment.systemPackages = with pkgs; [
    remmina
    freerdp
    virt-viewer
    libvirt
    qemu
    spice-protocol
    spice-gtk
    packer

    pciutils
    kmod
    davfs2

    quickemu
    quickgui
    vagrant
  ];
}
