{ config, lib, ... }: {
  options.features.services.power.acpid = {
    enable = lib.mkEnableOption "ACPI event handling";
  };

  config = lib.mkIf config.features.services.power.acpid.enable {
    services.acpid = {
      enable = true;
      acEventCommands = lib.mkIf config.features.desktop.hyprland.enable ''
        machinectl shell ${config.spec.user}@ /bin/sh -c "systemctl --user start hyprland-adjust-power"
      '';
    };
  };
}
