{
  func,
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}:
let
  cfg = config.features.core.home;
in
{
  options.features.core.home = {
    enable = lib.mkEnableOption "home-manager configuration";
  };

  config = lib.mkIf cfg.enable {
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

    systemd.tmpfiles.rules = lib.mkIf config.features.core.persistence.enable [
      "d ${config.features.core.persistence.folder}/${config.spec.user}/ 0777 root root -"
      "d ${config.features.core.persistence.folder}/home/${config.spec.user} 0700 ${config.spec.user} users -"
    ];
  };
}
