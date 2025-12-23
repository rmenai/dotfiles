{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.apps.development.python = {
    enable = lib.mkEnableOption "Python development tools";
  };

  config = lib.mkIf config.features.apps.development.python.enable {
    home.packages = with pkgs; [ uv ];
  };
}
