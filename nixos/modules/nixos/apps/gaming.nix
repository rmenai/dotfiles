{ config, lib, pkgs, ... }: {
  options.features.apps.gaming = {
    enable = lib.mkEnableOption "gaming applications and optimizations";
  };

  config = lib.mkIf config.features.apps.gaming.enable {
    programs.gamemode.enable = true;
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    environment.sessionVariables = {
      GAMEMODERUNEXEC =
        lib.mkIf config.features.hardware.nvidia.enable "nvidia-offload";
    };

    environment.systemPackages = with pkgs;
      [ steam-run mangohud gamescope itch ]
      ++ lib.optionals config.features.hardware.nvidia.enable [
        (pkgs.writeShellScriptBin "gamerun" ''
          #!/usr/bin/env bash
          exec nvidia-offload gamemoderun steam-run "$@"
        '')
      ];

    # Add user to required groups
    users.users.${config.spec.user}.extraGroups = [ "gamemode" ];
  };
}
