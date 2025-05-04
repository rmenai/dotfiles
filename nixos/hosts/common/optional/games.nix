{pkgs, ...}: {
  programs.gamemode.enable = true;

  environment.sessionVariables = {
    GAMEMODERUNEXEC = "nvidia-offload";
  };

  environment.systemPackages = with pkgs; [
    steam-run
  ];
}
