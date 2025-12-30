{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.features.apps.dev.rust;
  tomlFormat = pkgs.formats.toml { };
in
{
  options.features.apps.dev.rust = {
    enable = lib.mkEnableOption "Rust Toolchain";
  };

  config = lib.mkIf cfg.enable {
    home.sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
    ];

    home.packages = [ pkgs.rustup ];

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
          "wezterm"
          "cli"
          "spawn"
          "--cwd"
          "."
          "--"
          "nvim"
          "$FILE"
        ];
      };
    };
  };
}
