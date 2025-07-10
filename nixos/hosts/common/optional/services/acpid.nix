{config, ...}: {
  services.acpid = {
    enable = true;
    acEventCommands = ''
      # machinectl shell ${config.spec.user}@ /bin/sh -c "systemctl --user start hyprland-adjust-power"
    '';
  };
}
