{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = [pkgs.virtiofsd];
  virtualisation.spiceUSBRedirection.enable = true;

  services.spice-vdagentd.enable = true;
  programs.virt-manager.enable = true;

  # https://www.rodolfocarvalho.net/blog/resize-disk-vagrant-libvirt/
  boot.kernelModules = ["kvm-intel" "9p" "9pnet" "9pnet_virtio"];
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  environment.sessionVariables = {
    VAGRANT_DEFAULT_PROVIDER = "libvirt";
  };

  environment.persistence."/persist/system" = {
    directories = [
      "/var/lib/libvirt"
    ];
  };

  environment.systemPackages = with pkgs; [
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
