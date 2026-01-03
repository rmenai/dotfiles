{ config, lib, ... }:
let
  cfg = config.features.profiles.core;
in
{
  options.features.profiles.core = {
    enable = lib.mkEnableOption "Core profile";
  };

  config = lib.mkIf cfg.enable {
    features = {
      core = {
        nix.enable = true;
        home.enable = true;
        sops.enable = true;
      };

      apps.tools = {
        git.enable = true;
        ssh.enable = true;
      };
    };

    home.shellAliases = {
      hibernate = "systemctl hibernate";
      suspend = "systemctl suspend";

      ll = "ls -l";
      la = "ls -a";

      warp = "wormhole-rs";
    };

    home.sessionPath = [
      "~/.local/bin"
    ];
  };
}
