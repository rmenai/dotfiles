{pkgs, ...}: {
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    steam-run
  ];
}
