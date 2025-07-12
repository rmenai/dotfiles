{ config, lib, pkgs, ... }: {
  options.features.services.virtualization.waydroid = {
    enable = lib.mkEnableOption "Waydroid Android containers";
  };

  config = lib.mkIf config.features.services.virtualization.waydroid.enable {
    virtualisation.waydroid.enable = true;

    features.persist = { directories = { "/var/lib/waydroid" = true; }; };

    environment.systemPackages = with pkgs; [
      pciutils
      kmod
      davfs2
      quickemu
      quickgui
    ];
  };
}
