{
  config,
  inputs,
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

      layouts.default = ''
        layout {
            default_tab_template {
                children

                pane size=2 borderless=true {
                    plugin location="file:${inputs.zjstatus}" {
                        // Catppuccin Mocha colors
                        color_rosewater "#f5e0dc"
                        color_flamingo "#f2cdcd"
                        color_pink "#f5c2e7"
                        color_mauve "#cba6f7"
                        color_red "#f38ba8"
                        color_maroon "#eba0ac"
                        color_peach "#fab387"
                        color_yellow "#f9e2af"
                        color_green "#a6e3a1"
                        color_teal "#94e2d5"
                        color_sky "#89dceb"
                        color_sapphire "#74c7ec"
                        color_blue "#89b4fa"
                        color_lavender "#b4befe"
                        color_text "#cdd6f4"
                        color_subtext1 "#bac2de"
                        color_subtext0 "#a6adc8"
                        color_overlay2 "#9399b2"
                        color_overlay1 "#7f849c"
                        color_overlay0 "#6c7086"
                        color_surface2 "#585b70"
                        color_surface1 "#45475a"
                        color_surface0 "#313244"
                        color_base "#1e1e2e"
                        color_mantle "#181825"
                        color_crust "#11111b"

                        format_left   "{mode}#[fg=$lavender,bold] {session}"
                        format_center "{tabs}"
                        format_right  "{datetime}"
                        format_space  ""
                        format_hide_on_overlength "true"
                        format_precedence "crl"

                        border_enabled  "true"
                        border_char     "─"
                        border_format   "#[fg=$overlay0]{char}"
                        border_position "top"

                        mode_normal        "#[bg=$lavender,fg=$base,bold] NORMAL #[fg=$lavender,bg=$surface0]"
                        mode_locked        "#[bg=$overlay0,fg=$base,bold] LOCKED #[fg=$overlay0,bg=$surface0]"
                        mode_resize        "#[bg=$red,fg=$base,bold] RESIZE #[fg=$red,bg=$surface0]"
                        mode_pane          "#[bg=$lavender,fg=$base,bold] PANE #[fg=$lavender,bg=$surface0]"
                        mode_tab           "#[bg=$green,fg=$base,bold] TAB #[fg=$green,bg=$surface0]"
                        mode_scroll        "#[bg=$yellow,fg=$base,bold] SCROLL #[fg=$yellow,bg=$surface0]"
                        mode_enter_search  "#[bg=$peach,fg=$base,bold] ENT-SEARCH #[fg=$peach,bg=$surface0]"
                        mode_search        "#[bg=$peach,fg=$base,bold] SEARCH #[fg=$peach,bg=$surface0]"
                        mode_rename_tab    "#[bg=$green,fg=$base,bold] RENAME-TAB #[fg=$green,bg=$surface0]"
                        mode_rename_pane   "#[bg=$lavender,fg=$base,bold] RENAME-PANE #[fg=$lavender,bg=$surface0]"
                        mode_session       "#[bg=$mauve,fg=$base,bold] SESSION #[fg=$mauve,bg=$surface0]"
                        mode_move          "#[bg=$pink,fg=$base,bold] MOVE #[fg=$pink,bg=$surface0]"
                        mode_prompt        "#[bg=$lavender,fg=$base,bold] PROMPT #[fg=$lavender,bg=$surface0]"
                        mode_tmux          "#[bg=$peach,fg=$base,bold] TMUX #[fg=$peach,bg=$surface0]"

                        tab_normal              "#[fg=$overlay0] {name} "
                        tab_normal_fullscreen   "#[fg=$overlay0] {name} [] "
                        tab_normal_sync         "#[fg=$overlay0] {name} <> "
                        tab_active              "#[fg=$lavender,bold,italic] {name} "
                        tab_active_fullscreen   "#[fg=$lavender,bold,italic] {name} [] "
                        tab_active_sync         "#[fg=$lavender,bold,italic] {name} <> "

                        datetime          "#[fg=$overlay0,bold] {format} "
                        datetime_format   "%a %d %b %H:%M"
                        datetime_timezone "Europe/Amsterdam"
                    }
                }
            }
        }
      '';

      extraConfig = ''
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

        keybinds clear-defaults=true {
            locked {
                bind "Alt g" { SwitchToMode "Normal"; }
            }
            resize {
                bind "Alt n" { SwitchToMode "Normal"; }
                bind "h" "Left" { Resize "Increase Left"; }
                bind "j" "Down" { Resize "Increase Down"; }
                bind "k" "Up" { Resize "Increase Up"; }
                bind "l" "Right" { Resize "Increase Right"; }
                bind "H" { Resize "Decrease Left"; }
                bind "J" { Resize "Decrease Down"; }
                bind "K" { Resize "Decrease Up"; }
                bind "L" { Resize "Decrease Right"; }
                bind "=" "+" { Resize "Increase"; }
                bind "-" { Resize "Decrease"; }
            }
            pane {
                bind "Alt p" { SwitchToMode "Normal"; }
                bind "h" "Left" { MoveFocus "Left"; }
                bind "l" "Right" { MoveFocus "Right"; }
                bind "j" "Down" { MoveFocus "Down"; }
                bind "k" "Up" { MoveFocus "Up"; }
                bind "p" { SwitchFocus; }
                bind "n" { NewPane; SwitchToMode "Normal"; }
                bind "d" { NewPane "Down"; SwitchToMode "Normal"; }
                bind "r" { NewPane "Right"; SwitchToMode "Normal"; }
                bind "s" { NewPane "stacked"; SwitchToMode "Normal"; }
                bind "x" { CloseFocus; SwitchToMode "Normal"; }
                bind "f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
                bind "z" { TogglePaneFrames; SwitchToMode "Normal"; }
                bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
                bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
                bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0; }
                bind "i" { TogglePanePinned; SwitchToMode "Normal"; }
            }
            move {
                bind "Alt h" { SwitchToMode "Normal"; }
                bind "n" "Tab" { MovePane; }
                bind "p" { MovePaneBackwards; }
                bind "h" "Left" { MovePane "Left"; }
                bind "j" "Down" { MovePane "Down"; }
                bind "k" "Up" { MovePane "Up"; }
                bind "l" "Right" { MovePane "Right"; }
            }
            tab {
                bind "Alt t" { SwitchToMode "Normal"; }
                bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
                bind "h" "Left" "Up" "k" { GoToPreviousTab; }
                bind "l" "Right" "Down" "j" { GoToNextTab; }
                bind "n" { NewTab; SwitchToMode "Normal"; }
                bind "x" { CloseTab; SwitchToMode "Normal"; }
                bind "s" { ToggleActiveSyncTab; SwitchToMode "Normal"; }
                bind "b" { BreakPane; SwitchToMode "Normal"; }
                bind "]" { BreakPaneRight; SwitchToMode "Normal"; }
                bind "[" { BreakPaneLeft; SwitchToMode "Normal"; }
                bind "1" { GoToTab 1; SwitchToMode "Normal"; }
                bind "2" { GoToTab 2; SwitchToMode "Normal"; }
                bind "3" { GoToTab 3; SwitchToMode "Normal"; }
                bind "4" { GoToTab 4; SwitchToMode "Normal"; }
                bind "5" { GoToTab 5; SwitchToMode "Normal"; }
                bind "6" { GoToTab 6; SwitchToMode "Normal"; }
                bind "7" { GoToTab 7; SwitchToMode "Normal"; }
                bind "8" { GoToTab 8; SwitchToMode "Normal"; }
                bind "9" { GoToTab 9; SwitchToMode "Normal"; }
                bind "Tab" { ToggleTab; }
            }
            scroll {
                bind "Alt s" { SwitchToMode "Normal"; }
                bind "e" { EditScrollback; SwitchToMode "Normal"; }
                bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
                bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
                bind "j" "Down" { ScrollDown; }
                bind "k" "Up" { ScrollUp; }
                bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
                bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
                bind "d" { HalfPageScrollDown; }
                bind "u" { HalfPageScrollUp; }
            }
            search {
                bind "Alt s" { SwitchToMode "Normal"; }
                bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
                bind "j" "Down" { ScrollDown; }
                bind "k" "Up" { ScrollUp; }
                bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
                bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
                bind "d" { HalfPageScrollDown; }
                bind "u" { HalfPageScrollUp; }
                bind "n" { Search "down"; }
                bind "p" { Search "up"; }
                bind "c" { SearchToggleOption "CaseSensitivity"; }
                bind "w" { SearchToggleOption "Wrap"; }
                bind "o" { SearchToggleOption "WholeWord"; }
            }
            entersearch {
                bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
                bind "Enter" { SwitchToMode "Search"; }
            }
            renametab {
                bind "Ctrl c" { SwitchToMode "Normal"; }
                bind "Esc" { UndoRenameTab; SwitchToMode "Tab"; }
            }
            renamepane {
                bind "Ctrl c" { SwitchToMode "Normal"; }
                bind "Esc" { UndoRenamePane; SwitchToMode "Pane"; }
            }
            session {
                bind "Alt o" { SwitchToMode "Normal"; }
                bind "Alt s" { SwitchToMode "Scroll"; }
                bind "d" { Detach; }
                bind "w" {
                    LaunchOrFocusPlugin "session-manager" {
                        floating true
                        move_to_focused_tab true
                    };
                    SwitchToMode "Normal"
                }
                bind "c" {
                    LaunchOrFocusPlugin "configuration" {
                        floating true
                        move_to_focused_tab true
                    };
                    SwitchToMode "Normal"
                }
                bind "p" {
                    LaunchOrFocusPlugin "plugin-manager" {
                        floating true
                        move_to_focused_tab true
                    };
                    SwitchToMode "Normal"
                }
                bind "a" {
                    LaunchOrFocusPlugin "zellij:about" {
                        floating true
                        move_to_focused_tab true
                    };
                    SwitchToMode "Normal"
                }
                bind "s" {
                    LaunchOrFocusPlugin "zellij:share" {
                        floating true
                        move_to_focused_tab true
                    };
                    SwitchToMode "Normal"
                }
            }
            tmux {
                bind "[" { SwitchToMode "Scroll"; }
                bind "Ctrl b" { Write 2; SwitchToMode "Normal"; }
                bind "\"" { NewPane "Down"; SwitchToMode "Normal"; }
                bind "%" { NewPane "Right"; SwitchToMode "Normal"; }
                bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
                bind "c" { NewTab; SwitchToMode "Normal"; }
                bind "," { SwitchToMode "RenameTab"; }
                bind "p" { GoToPreviousTab; SwitchToMode "Normal"; }
                bind "n" { GoToNextTab; SwitchToMode "Normal"; }
                bind "Left" { MoveFocus "Left"; SwitchToMode "Normal"; }
                bind "Right" { MoveFocus "Right"; SwitchToMode "Normal"; }
                bind "Down" { MoveFocus "Down"; SwitchToMode "Normal"; }
                bind "Up" { MoveFocus "Up"; SwitchToMode "Normal"; }
                bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
                bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
                bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
                bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }
                bind "o" { FocusNextPane; }
                bind "d" { Detach; }
                bind "Space" { NextSwapLayout; }
                bind "x" { CloseFocus; SwitchToMode "Normal"; }
            }
            shared_except "locked" {
                // vim-zellij-navigator bindings
                bind "Ctrl h" { MessagePlugin "z-nav" { name "move_focus_or_tab"; payload "left"; move_mod "ctrl"; }; }
                bind "Ctrl j" { MessagePlugin "z-nav" { name "move_focus"; payload "down"; move_mod "ctrl"; }; }
                bind "Ctrl k" { MessagePlugin "z-nav" { name "move_focus"; payload "up"; move_mod "ctrl"; }; }
                bind "Ctrl l" { MessagePlugin "z-nav" { name "move_focus_or_tab"; payload "right"; move_mod "ctrl"; }; }
                bind "Ctrl Alt h" { MessagePlugin "z-nav" { name "resize"; payload "left"; resize_mod "ctrl+alt"; }; }
                bind "Ctrl Alt j" { MessagePlugin "z-nav" { name "resize"; payload "down"; resize_mod "ctrl+alt"; }; }
                bind "Ctrl Alt k" { MessagePlugin "z-nav" { name "resize"; payload "up"; resize_mod "ctrl+alt"; }; }
                bind "Ctrl Alt l" { MessagePlugin "z-nav" { name "resize"; payload "right"; resize_mod "ctrl+alt"; }; }
                // Other shared bindings
                bind "Alt g" { SwitchToMode "Locked"; }
                bind "Alt q" { Quit; }
                bind "Ctrl Alt f" { ToggleFloatingPanes; }
                bind "Ctrl Alt n" { NewPane; }
                bind "Ctrl Alt i" { MoveTab "Left"; }
                bind "Ctrl Alt o" { MoveTab "Right"; }
                bind "Alt Left" { MoveFocusOrTab "Left"; }
                bind "Alt Right" { MoveFocusOrTab "Right"; }
                bind "Alt Down" { MoveFocus "Down"; }
                bind "Alt Up" { MoveFocus "Up"; }
                bind "Ctrl Alt =" "Alt +" { Resize "Increase"; }
                bind "Ctrl Alt -" { Resize "Decrease"; }
                bind "Ctrl Alt [" { PreviousSwapLayout; }
                bind "Ctrl Alt ]" { NextSwapLayout; }
                bind "Ctrl Alt p" { TogglePaneInGroup; }
                bind "Ctrl Alt Shift p" { ToggleGroupMarking; }
            }
            shared_except "normal" "locked" {
                bind "Enter" "Esc" { SwitchToMode "Normal"; }
            }
            shared_except "pane" "locked" {
                bind "Alt p" { SwitchToMode "Pane"; }
            }
            shared_except "resize" "locked" {
                bind "Alt n" { SwitchToMode "Resize"; }
            }
            shared_except "scroll" "locked" {
                bind "Alt s" { SwitchToMode "Scroll"; }
            }
            shared_except "session" "locked" {
                bind "Alt o" { SwitchToMode "Session"; }
            }
            shared_except "tab" "locked" {
                bind "Alt t" { SwitchToMode "Tab"; }
            }
            shared_except "move" "locked" {
                bind "Alt h" { SwitchToMode "Move"; }
            }
            shared_except "tmux" "locked" {
                bind "Alt b" { SwitchToMode "Tmux"; }
            }
        }
      '';
    };

    catppuccin.zellij.enable = lib.mkForce false;
  };
}
