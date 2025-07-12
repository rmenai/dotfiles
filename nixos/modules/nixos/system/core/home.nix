{ config, lib, pkgs, inputs, outputs, ... }: {
  options.features.system.home = {
    enable = lib.mkEnableOption "home-manager configuration";
  };

  config = lib.mkIf config.features.system.home.enable {
    home-manager = {
      useUserPackages = true;

      extraSpecialArgs = { inherit pkgs inputs outputs; };

      backupFileExtension = "backup-" + pkgs.lib.readFile
        "${pkgs.runCommand "timestamp" { }
        "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";

      users.${config.spec.user}.imports = [
        (lib.custom.relativeToRoot
          "home/${config.spec.user}/${config.spec.hostName}.nix")
      ];
    };

    systemd.tmpfiles.rules = lib.mkIf config.features.impermanence.enable [
      "d ${config.features.impermanence.persistFolder}/${config.spec.user}/ 0777 root root -"
      "d ${config.features.impermanence.persistFolder}/home/${config.spec.user} 0700 ${config.spec.user} users -"
    ];
  };
}
