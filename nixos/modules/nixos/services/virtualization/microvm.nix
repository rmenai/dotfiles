{ config, lib, ... }: {
  options.features.services.virtualization.microvm = {
    enable = lib.mkEnableOption "MicroVM virtualization";
  };

  config = lib.mkIf config.features.services.virtualization.microvm.enable {
    features.persist = { directories = { "/var/lib/microvms" = true; }; };
  };
}
