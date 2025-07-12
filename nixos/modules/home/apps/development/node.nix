{ config, lib, pkgs, ... }: {
  options.features.apps.development.node = {
    enable = lib.mkEnableOption "Node.js development tools";
  };

  config = lib.mkIf config.features.apps.development.node.enable {
    home.packages = with pkgs; [ fnm ];

    features.persist = { directories = { ".bun" = lib.mkDefault true; }; };
  };
}
