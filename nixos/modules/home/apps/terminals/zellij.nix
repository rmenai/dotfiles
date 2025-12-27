{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.terminals.zellij;

  znavPlugin = pkgs.fetchurl {
    url = "https://github.com/hiasr/vim-zellij-navigator/releases/download/0.3.0/vim-zellij-navigator.wasm";
    sha256 = "sha256-d+Wi9i98GmmMryV0ST1ddVh+D9h3z7o0xIyvcxwkxY0=";
  };
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
        pane_frames = false;
        copy_command = "wl-copy";
        mouse_mode = true;
        show_startup_tips = false;

        plugins = {
          "z-nav" = {
            location = "file:${znavPlugin}";
          };
        };

        keybinds = {
          "shared_except \"locked\"" = {
            "bind \"Ctrl h\"" = {
              MessagePlugin = {
                _args = [ "z-nav" ];
                name = "move_focus_or_tab";
                payload = "left";
                move_mod = "ctrl";
              };
            };
            "bind \"Ctrl j\"" = {
              MessagePlugin = {
                _args = [ "z-nav" ];
                name = "move_focus";
                payload = "down";
                move_mod = "ctrl";
              };
            };
            "bind \"Ctrl k\"" = {
              MessagePlugin = {
                _args = [ "z-nav" ];
                name = "move_focus";
                payload = "up";
                move_mod = "ctrl";
              };
            };
            "bind \"Ctrl l\"" = {
              MessagePlugin = {
                _args = [ "z-nav" ];
                name = "move_focus_or_tab";
                payload = "right";
                move_mod = "ctrl";
              };
            };
            "bind \"Alt h\"" = {
              MessagePlugin = {
                _args = [ "z-nav" ];
                name = "resize";
                payload = "left";
                resize_mod = "alt";
              };
            };
            "bind \"Alt j\"" = {
              MessagePlugin = {
                _args = [ "z-nav" ];
                name = "resize";
                payload = "down";
                resize_mod = "alt";
              };
            };
            "bind \"Alt k\"" = {
              MessagePlugin = {
                _args = [ "z-nav" ];
                name = "resize";
                payload = "up";
                resize_mod = "alt";
              };
            };
            "bind \"Alt l\"" = {
              MessagePlugin = {
                _args = [ "z-nav" ];
                name = "resize";
                payload = "right";
                resize_mod = "alt";
              };
            };
          };
        };
      };
    };

    catppuccin.zellij.enable = true;
  };
}
