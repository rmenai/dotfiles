{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland window manager";
  };

  config = lib.mkIf config.features.desktop.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      sway
      waypipe
      kitty
    ];

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
