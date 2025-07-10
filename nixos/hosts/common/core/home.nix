{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  home-manager = {
    extraSpecialArgs = {
      inherit pkgs inputs;
    };

    users.${config.spec.user}.imports = [
      (lib.custom.relativeToRoot "home/${config.spec.user}/${config.spec.hostName}.nix")
    ];
  };

  systemd.tmpfiles.rules = lib.mkIf config.features.impermanence.enable [
    "d ${config.features.impermanence.persistFolder}/${config.spec.user}/ 0777 root root -"
    "d ${config.features.impermanence.persistFolder}/home/${config.spec.user} 0700 ${config.spec.user} users -"
  ];
}
