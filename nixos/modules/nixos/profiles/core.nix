{ config, lib, ... }: {
  options.features.profiles.core = {
    enable = lib.mkEnableOption "Core profile";
  };

  config = lib.mkIf config.features.profiles.core.enable {
    system.stateVersion = lib.mkDefault "25.11";

    features = {
      system = {
        nix.enable = true;
        home.enable = true;
      };

      services = { security.sops.enable = true; };
      apps = { core.enable = true; };
    };

    security.sudo.extraConfig = ''
      Defaults !tty_tickets # share authentication across all ttys, not one per-tty
      Defaults lecture = never # rollback results in sudo lectures after each reboot
      Defaults timestamp_timeout=120 # only ask for password every 2h
    '';
  };
}
