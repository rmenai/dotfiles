{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.features.apps.terminals.zellij;
  mkLink = config.features.core.dotfiles.mkLink;
in
{
  options.features.apps.terminals.zellij = {
    enable = lib.mkEnableOption "Zellij terminal multiplexer";
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."zellij/layouts".source = mkLink ./layouts;

    programs.zellij = {
      enable = true;

      settings = {
        default_shell = "${pkgs.nushell}/bin/nu";
        scrollback_editor = "nvim";
        show_startup_tips = false;
        default_layout = "default";
        theme = "catppuccin";
        pane_frames = false;
        copy_command = "wl-copy";
        mouse_mode = true;

        plugins = {
          "z-status".location = "file:${inputs.zjstatus}";
          "z-nav".location = "file:${inputs.zjnav}";
        };
      };

      extraConfig = builtins.readFile ./binds.kdl;
    };
  };
}
