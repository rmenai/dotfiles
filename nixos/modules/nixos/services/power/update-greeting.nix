{ config, lib, pkgs, ... }: {
  options.features.services.power.update-greeting = {
    enable = lib.mkEnableOption "Show ip address in greeting";
  };

  config = lib.mkIf config.features.services.power.update-greeting.enable {
    networking.dhcpcd.runHook = "${pkgs.utillinux}/bin/agetty --reload";
    environment.etc."issue.d/ip.issue".text = ''
      \4
    '';
  };
}
