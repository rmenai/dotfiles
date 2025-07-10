{config, ...}: {
  services.acpid = {
    enable = true;
    acEventCommands = ''
      # machinectl shell ${config.spec.username}@ /bin/sh -c "systemctl --user start hyprland-adjust-power"
    '';
  };
}
