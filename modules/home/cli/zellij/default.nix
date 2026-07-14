{ config, pkgs, ... }:
let
  mkLink = config.dotfiles.mkLink;
in
{
  imports = [
    ./plugins.nix
    ./theme.nix
  ];

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
    };

    extraConfig = builtins.readFile ./binds.kdl;
  };
}
