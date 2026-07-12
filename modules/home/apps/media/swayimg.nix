{
  config,
  lib,
  ...
}:
let
  cfg = config.features.apps.media.swayimg;
in
{
  options.features.apps.media.swayimg = {
    enable = lib.mkEnableOption "Imv Image viewer";
  };

  config = lib.mkIf cfg.enable {
    programs.swayimg = {
      enable = true;
      initLua = ''
        -- General Settings
        config.general.size = "image"

        -- Viewer Settings
        config.viewer.window = "00000000"
        config.viewer.transparency = "00000000"
        config.viewer.scale = "real"

        -- List & Info Settings
        config.list.all = true
        config.info.show = false

        -- Viewer Keybindings
        -- Navigation
        bind.viewer("j", "next_file")
        bind.viewer("k", "prev_file")
        bind.viewer("Shift+g", "last_file")
        bind.viewer("g", "first_file")

        -- Panning
        bind.viewer("h", "step_left 10")
        bind.viewer("l", "step_right 10")

        -- Logical Directory Jumping
        bind.viewer("Shift+j", "next_dir")
        bind.viewer("Shift+k", "prev_dir")

        -- Gallery Keybindings
        -- Grid Movement
        bind.gallery("h", "step_left")
        bind.gallery("j", "step_down")
        bind.gallery("k", "step_up")
        bind.gallery("l", "step_right")

        -- List Limits
        bind.gallery("Shift+g", "last_file")
        bind.gallery("g", "first_file")
      '';
    };

    xdg.mimeApps.defaultApplications = {
      "image/jpeg" = "swayimg.desktop";
      "image/png" = "swayimg.desktop";
      "image/gif" = "swayimg.desktop";
      "image/webp" = "swayimg.desktop";
      "image/bmp" = "swayimg.desktop";
      "image/tiff" = "swayimg.desktop";
      "image/svg+xml" = "swayimg.desktop";
    };
  };
}
