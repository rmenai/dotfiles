{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.services.virtualbox;
  libvirtEnabled = config.features.services.libvirt.enable or false;
in
{
  options.features.services.virtualbox = {
    enable = lib.mkEnableOption "VirtualBox virtualization";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host = {
      enable = true;
      package = pkgs.stable.virtualbox;

      # KVM support is only enabled if the libvirt feature is also active
      enableKvm = libvirtEnabled;

      enableExtensionPack = true;
      enableHardening = false;
      addNetworkInterface = false;
    };

    features.core.persistence = {
      directories = [
        "/etc/vbox"
      ];
    };

    users.users.${config.spec.user}.extraGroups = [ "vboxusers" ];
  };
}
