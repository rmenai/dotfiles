{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.apps.development.rust = {
    enable = lib.mkEnableOption "Rust development tools";
  };

  config = lib.mkIf config.features.apps.development.rust.enable {
    home.packages = with pkgs; [ rustup ];

    features.dotfiles = {
      paths = {
        ".config/rust-competitive-helper" = lib.mkDefault "rust-competitive-helper";
        ".config/bacon" = lib.mkDefault "bacon";
      };
    };

    features.persist = {
      directories = {
        ".cargo" = lib.mkDefault true;
        ".rustup" = lib.mkDefault true;
      };
    };
  };
}
