{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.features.apps.dev.rust;
  tomlFormat = pkgs.formats.toml { };

  competitive-open = pkgs.writeShellScriptBin "competitive-open" ''
    #!/bin/sh
    FILE="$1"
    DIR="$(pwd)"

    zellij action new-tab
    zellij action write-chars "nvim $FILE"
    zellij action write 13  # Enter key
    zellij action new-pane --direction down
    zellij action write-chars "cd $DIR; bacon"
    zellij action write 13  # Enter key

    # Resize bacon pane to ~20% (decrease 6 times)
    for i in {1..4}; do
      zellij action resize decrease up
    done

    zellij action focus-previous-pane
  '';
in
{
  options.features.apps.dev.rust = {
    enable = lib.mkEnableOption "Rust Toolchain";
  };

  config = lib.mkIf cfg.enable {
    home.sessionPath = [ "~/.cargo/bin" ];

    home.packages = [
      pkgs.rustup
      competitive-open
    ];

    programs.bacon = {
      enable = true;
      package = null; # Installed via rustup

      settings = {
        jobs = {
          bacon-ls = {
            command = [
              "cargo"
              "clippy"
              "--workspace"
              "--tests"
              "--all-targets"
              "--all-features"
              "--message-format"
              "json-diagnostic-rendered-ansi"
            ];
            analyzer = "cargo_json";
            need_stdout = true;
          };
        };

        exports = {
          cargo-json-spans = {
            auto = true;
            exporter = "analyzer";
            # Standard quotes are safe here because the braces are '{}', not '${}'.
            line_format = "{diagnostic.level}|:|{span.file_name}|:|{span.line_start}|:|{span.line_end}|:|{span.column_start}|:|{span.column_end}|:|{diagnostic.message}|:|{diagnostic.rendered}|:|{span.suggested_replacement}";
            path = ".bacon-locations";
          };
        };
      };
    };

    xdg.configFile."rust-competitive-helper/rust-competitive-helper.toml" = {
      source = tomlFormat.generate "rust-competitive-helper-config" {
        open_task_command = [
          "competitive-open"
          "$FILE"
        ];
      };
    };
  };
}
