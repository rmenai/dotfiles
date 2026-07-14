{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wineWow64Packages.waylandFull
    dualsensectl
    bottles
  ];

  programs = {
    gamemode.enable = true;
    gamescope.enable = true;

    steam = {
      enable = true;
      gamescopeSession.enable = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };

  # Make ps5 controller work
  hardware.steam-hardware.enable = true;
  boot.kernelModules = [ "hid-playstation" ];
  services.udev.packages = [ pkgs.game-devices-udev-rules ];

  # Work around for issue with capSysNice not working in gamescope
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    extraRules = [
      {
        "name" = "gamescope";
        "nice" = -20;
      }
    ];
  };
}
