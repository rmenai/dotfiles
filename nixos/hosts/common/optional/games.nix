{pkgs, ...}: {
  programs.gamemode.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  environment.sessionVariables = {
    GAMEMODERUNEXEC = "nvidia-offload";
  };

  environment.systemPackages = with pkgs; [
    steam-run
    mangohud
    gamescope
    itch

    (pkgs.writeShellScriptBin "gamerun" ''
      #!/usr/bin/env bash
      exec nvidia-offload gamemoderun steam-run "$@"
    '')
  ];
}
