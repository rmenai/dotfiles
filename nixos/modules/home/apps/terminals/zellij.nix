{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.terminals.zellij;
in
{
  options.features.apps.terminals.zellij = {
    enable = lib.mkEnableOption "Zellij terminal multiplexer";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;

      settings = {
        default_shell = "${pkgs.nushell}/bin/nu";
        # default_layout = "compact";
        pane_frames = false;
        copy_command = "wl-copy";
        mouse_mode = true;
        show_startup_tips = false;
      };
    };

    catppuccin.zellij.enable = true;
  };
}
