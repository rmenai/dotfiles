{ pkgs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.runAsRoot = true;
      qemu.vhostUserPackages = [ pkgs.virtiofsd ];
    };
    spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;
  programs.virt-manager.enable = true;

  # https://www.rodolfocarvalho.net/blog/resize-disk-vagrant-libvirt/
  boot = {
    kernelModules = [
      "9p"
      "9pnet"
      "9pnet_virtio"
    ];

    extraModprobeConfig = "options kvm_intel nested=1";
  };

  environment = {
    sessionVariables = {
      VAGRANT_DEFAULT_PROVIDER = "libvirt";
      LIBVIRT_DEFAULT_URI = "qemu:///system";
    };

    systemPackages = with pkgs; [
      virt-viewer
      libvirt
      libvirt-glib
      spice-protocol
      spice-gtk
      qemu
    ];
  };
}
