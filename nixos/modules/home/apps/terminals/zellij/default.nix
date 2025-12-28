{ lib, ... }:
{
  options.features.apps.terminals.zellij = {
    enable = lib.mkEnableOption "Zellij terminal multiplexer";
  };
}
