{
  func,
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}:
{
  options.features.system.home = {
    enable = lib.mkEnableOption "home-manager configuration";
  };

  config = lib.mkIf config.features.system.home.enable {
    home-manager = {
      useUserPackages = true;

      extraSpecialArgs = {
        inherit
          func
          pkgs
          inputs
          outputs
          ;
      };

      users.${config.spec.user}.imports = [
        (func.custom.relativeToRoot "home/${config.spec.user}/${config.spec.host}.nix")
      ];
    };

    systemd.tmpfiles.rules = lib.mkIf config.features.impermanence.enable [
      "d ${config.features.impermanence.persistFolder}/${config.spec.user}/ 0777 root root -"
      "d ${config.features.impermanence.persistFolder}/home/${config.spec.user} 0700 ${config.spec.user} users -"
    ];
  };
}
