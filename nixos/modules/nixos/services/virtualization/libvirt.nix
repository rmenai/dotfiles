{ config, lib, pkgs, ... }: {
  options.features.services.virtualization.libvirt = {
    enable = lib.mkEnableOption "libvirt virtualization";
  };

  config = lib.mkIf config.features.services.virtualization.libvirt.enable {
    virtualisation.libvirtd.enable = true;
    virtualisation.libvirtd.qemu.vhostUserPackages = [ pkgs.virtiofsd ];
    virtualisation.spiceUSBRedirection.enable = true;

    services.spice-vdagentd.enable = true;
    programs.virt-manager.enable = true;

    # https://www.rodolfocarvalho.net/blog/resize-disk-vagrant-libvirt/
    boot.kernelModules = [ "9p" "9pnet" "9pnet_virtio" ];
    boot.extraModprobeConfig = "options kvm_intel nested=1";

    environment.sessionVariables = {
      VAGRANT_DEFAULT_PROVIDER = "libvirt";
      LIBVIRT_DEFAULT_URI = "qemu:///system";
    };

    users.users.${config.spec.user}.extraGroups = [ "libvirtd" "kvm" ];

    features.persist = { directories = { "/var/lib/libvirt" = true; }; };

    environment.systemPackages = [
      pkgs.remmina
      pkgs.freerdp
      pkgs.virt-viewer
      pkgs.libvirt
      pkgs.libvirt-glib
      pkgs.qemu
      pkgs.spice-protocol
      pkgs.spice-gtk
      pkgs.packer
      pkgs.stable.vagrant
    ];
  };
}
