{ config, lib, pkgs, ... }: {
  options.features.apps.terminals.kitty = {
    enable = lib.mkEnableOption "Kitty terminal emulator";
  };

  config = lib.mkIf config.features.apps.terminals.kitty.enable {
    home.packages = with pkgs; [ kitty ];

    features.dotfiles = {
      paths = { ".config/kitty" = lib.mkDefault "kitty"; };
    };
  };
}
