{ pkgs, lib, config, ... }: {
  options.features.apps.socials.discord = {
    enable = lib.mkEnableOption "Discord chat application";
  };

  config = lib.mkIf config.features.apps.socials.discord.enable {
    home.packages = with pkgs; [ discord ];

    features.dotfiles = {
      paths = { ".config/BetterDiscord" = lib.mkDefault "BetterDiscord"; };
    };
  };
}
