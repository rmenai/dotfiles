{ lib, config, ... }: {
  options.features.system.home = {
    enable = lib.mkEnableOption "core home-manager configuration";
  };

  config = lib.mkIf config.features.system.home.enable {
    home = {
      username = lib.mkDefault config.spec.user;
      homeDirectory = lib.mkDefault "/home/${config.spec.user}";
    };

    programs.home-manager.enable = true;
    systemd.user.startServices = "sd-switch";
  };
}
