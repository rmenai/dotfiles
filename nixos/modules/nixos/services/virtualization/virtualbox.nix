{ config, lib, pkgs, ... }: {
  options.features.services.virtualization.virtualbox = {
    enable = lib.mkEnableOption "VirtualBox virtualization";
  };

  config = lib.mkIf config.features.services.virtualization.virtualbox.enable {
    virtualisation.virtualbox.host = {
      enable = true;
      package = pkgs.stable.virtualbox;

      enableKvm = true;
      enableExtensionPack = true;
      enableHardening = false;
      addNetworkInterface = false;
    };

    users.users.${config.spec.user}.extraGroups = [ "vboxusers" ];

    features.persist = { directories = { "/etc/vbox" = true; }; };
  };
}
