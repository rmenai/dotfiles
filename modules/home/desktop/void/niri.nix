{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.void;
  mkLink = config.features.core.dotfiles.mkLink;
in
{
  config = lib.mkIf cfg.enable {
    xdg.configFile."niri".source = mkLink ./niri;

    home.packages = with pkgs; [
      imagemagick
      bc # Needed for math

      (writeShellScriptBin "swayimg-clipboard" ''
        #!/bin/sh
        SCALE=2.25 # 1.5 * 1.5
        TMP="/tmp/swayimg_clipboard_data"

        if wl-paste --type image/png > "$TMP" 2>/dev/null; then
          FILE="$TMP"
          echo "Mode: Binary Image detected"
        else
          PATH_STR=$(wl-paste | sed 's|^file://||')
          if [ -f "$PATH_STR" ]; then
            FILE="$PATH_STR"
            echo "Mode: File Path detected ($FILE)"
          fi
        fi

        if [ -n "$FILE" ]; then
          read W H <<< $(identify -format "%w %h" "$FILE")
          LOGICAL_W=$(echo "$W / $SCALE" | bc)
          LOGICAL_H=$(echo "$H / $SCALE" | bc)

          echo "$W x $H"
          echo "$LOGICAL_W x $LOGICAL_H"

          exec swayimg -a pinned_image -w "$LOGICAL_W,$LOGICAL_H" "$FILE"
        else
          notify-send "Niri" "Clipboard contains neither binary image nor valid file path"
        fi
      '')
    ];
  };
}
