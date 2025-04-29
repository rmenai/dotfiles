{config, ...}: {
  services.acpid = {
    enable = true;
    acEventCommands = ''
      # machinectl shell ${config.hostSpec.username}@ /bin/sh -c "systemctl --user start hyprland-adjust-power"
    '';
  };
}
