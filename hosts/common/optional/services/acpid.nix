{config, ...}: {
  services.acpid = {
    enable = true;
    acEventCommands = ''
      if grep -q "00000001" <<< "$1"; then
        machinectl shell ${config.hostSpec.username}@ /bin/sh -c "systemctl --user start hyprland-set-highres"
      else
        machinectl shell ${config.hostSpec.username}@ /bin/sh -c "systemctl --user start hyprland-set-battery"
      fi
    '';
  };
}
