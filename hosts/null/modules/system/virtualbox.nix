{ config, pkgs, ... }:
{
  virtualisation.virtualbox.host = {
    enable = true;
    package = pkgs.virtualbox;

    # KVM support is only enabled if the libvirt feature is also active
    enableKvm = config.virtualisation.libvirtd.enable;

    enableExtensionPack = true;
    enableHardening = false;
    addNetworkInterface = false;
  };
}
