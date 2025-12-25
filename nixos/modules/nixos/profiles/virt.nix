{ config, lib, ... }:
let
  cfg = config.features.profiles.virt;
in
{
  options.features.profiles.virt = {
    enable = lib.mkEnableOption "Virtualization Profile";

    includeTools = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to include GUI and CLI tools (Remmina, Vagrant, etc.)";
    };
  };

  config = lib.mkIf cfg.enable {
    features.services = {
      libvirt.enable = lib.mkDefault true;
      podman.enable = lib.mkDefault true;

      waydroid.enable = lib.mkDefault false;
      virtualbox.enable = lib.mkDefault false;
    };
  };
}
