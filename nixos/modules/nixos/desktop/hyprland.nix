{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.hyprland;
in
{
  options.features.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland Window Manager";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      sway
      waypipe
      kitty
    ];

    # Specific for wayland
    programs.ssh = {
      askPassword = "${pkgs.wofi}/bin/wofi --dmenu --password --prompt='SSH Password: '";
    };

    users.users.${config.spec.user}.extraGroups = [ "video" ];

    environment = {
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        WLR_NO_HARDWARE_CURSORS = "1";
        WLR_RENDERER_ALLOW_SOFTWARE = "1";
      };
    };
  };
}
