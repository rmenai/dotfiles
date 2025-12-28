{ config, lib, ... }:
let
  cfg = config.features.apps.terminals.zellij;
in
{
  config = lib.mkIf cfg.enable {
    catppuccin.zellij.enable = lib.mkForce false;

    programs.zellij.extraConfig = ''
      themes {
          catppuccin {
              text_unselected {
                  base 205 214 244 // #cdd6f4 Text
                  background 24 24 37 // #181825 Mantle
                  emphasis_0 250 179 135 // #fab387 Peach
                  emphasis_1 137 220 235 // #89dceb Sky
                  emphasis_2 166 227 161 // #a6e3a1 Green
                  emphasis_3 245 194 231 // #f5c2e7 Pink
              }
              text_selected {
                  base 205 214 244 // #cdd6f4 Text
                  background 88 91 112 // #585b70 Surface2
                  emphasis_0 250 179 135 // #fab387 Peach
                  emphasis_1 137 220 235 // #89dceb Sky
                  emphasis_2 166 227 161 // #a6e3a1 Green
                  emphasis_3 245 194 231 // #f5c2e7 Pink
              }
              ribbon_selected {
                  base 24 24 37 // #181825 Mantle
                  background 166 227 161 // #a6e3a1 Green
                  emphasis_0 243 139 168 // #f38ba8 Red
                  emphasis_1 250 179 135 // #fab387 Peach
                  emphasis_2 245 194 231 // #f5c2e7 Pink
                  emphasis_3 137 180 250 // #89b4fa Blue
              }
              ribbon_unselected {
                  base 24 24 37 // #181825 Mantle
                  background 205 214 244 // #cdd6f4 Text
                  emphasis_0 243 139 168 // #f38ba8 Red
                  emphasis_1 205 214 244 // #cdd6f4 Text
                  emphasis_2 137 180 250 // #89b4fa Blue
                  emphasis_3 245 194 231 // #f5c2e7 Pink
              }
              table_title {
                  base 166 227 161 // #a6e3a1 Green
                  background 0
                  emphasis_0 250 179 135 // #fab387 Peach
                  emphasis_1 137 220 235 // #89dceb Sky
                  emphasis_2 166 227 161 // #a6e3a1 Green
                  emphasis_3 245 194 231 // #f5c2e7 Pink
              }
              table_cell_selected {
                  base 205 214 244 // #cdd6f4 Text
                  background 88 91 112 // #585b70 Surface2
                  emphasis_0 250 179 135 // #fab387 Peach
                  emphasis_1 137 220 235 // #89dceb Sky
                  emphasis_2 166 227 161 // #a6e3a1 Green
                  emphasis_3 245 194 231 // #f5c2e7 Pink
              }
              table_cell_unselected {
                  base 205 214 244 // #cdd6f4 Text
                  background 24 24 37 // #181825 Mantle
                  emphasis_0 250 179 135 // #fab387 Peach
                  emphasis_1 137 220 235 // #89dceb Sky
                  emphasis_2 166 227 161 // #a6e3a1 Green
                  emphasis_3 245 194 231 // #f5c2e7 Pink
              }
              list_selected {
                  base 205 214 244 // #cdd6f4 Text
                  background 88 91 112 // #585b70 Surface2
                  emphasis_0 250 179 135 // #fab387 Peach
                  emphasis_1 137 220 235 // #89dceb Sky
                  emphasis_2 166 227 161 // #a6e3a1 Green
                  emphasis_3 245 194 231 // #f5c2e7 Pink
              }
              list_unselected {
                  base 205 214 244 // #cdd6f4 Text
                  background 24 24 37 // #181825 Mantle
                  emphasis_0 250 179 135 // #fab387 Peach
                  emphasis_1 137 220 235 // #89dceb Sky
                  emphasis_2 166 227 161 // #a6e3a1 Green
                  emphasis_3 245 194 231 // #f5c2e7 Pink
              }
              frame_selected {
                  base 180 190 254 // #b4befe Lavender
                  background 0
                  emphasis_0 250 179 135 // #fab387 Peach
                  emphasis_1 137 220 235 // #89dceb Sky
                  emphasis_2 245 194 231 // #f5c2e7 Pink
                  emphasis_3 0
              }
              frame_unselected {
                  base 108 112 134 // #6c7086 Overlay0
                  background 0
                  emphasis_0 250 179 135 // #fab387 Peach
                  emphasis_1 137 220 235 // #89dceb Sky
                  emphasis_2 245 194 231 // #f5c2e7 Pink
                  emphasis_3 0
              }
              frame_highlight {
                  base 180 190 254 // #b4befe Lavender
                  background 0
                  emphasis_0 245 194 231 // #f5c2e7 Pink
                  emphasis_1 250 179 135 // #fab387 Peach
                  emphasis_2 250 179 135 // #fab387 Peach
                  emphasis_3 250 179 135 // #fab387 Peach
              }
              exit_code_success {
                  base 166 227 161 // #a6e3a1 Green
                  background 0
                  emphasis_0 137 220 235 // #89dceb Sky
                  emphasis_1 24 24 37 // #181825 Mantle
                  emphasis_2 245 194 231 // #f5c2e7 Pink
                  emphasis_3 137 180 250 // #89b4fa Blue
              }
              exit_code_error {
                  base 243 139 168 // #f38ba8 Red
                  background 0
                  emphasis_0 249 226 175 // #f9e2af Yellow
                  emphasis_1 0
                  emphasis_2 0
                  emphasis_3 0
              }
              multiplayer_user_colors {
                  player_1 245 194 231 // #f5c2e7 Pink
                  player_2 137 180 250 // #89b4fa Blue
                  player_3 0
                  player_4 249 226 175 // #f9e2af Yellow
                  player_5 137 220 235 // #89dceb Sky
                  player_6 0
                  player_7 243 139 168 // #f38ba8 Red
                  player_8 0
                  player_9 0
                  player_10 0
              }
          }
      }
    '';
  };
}
