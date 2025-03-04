{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.${config.hostSpec.username} = {
    name = config.hostSpec.username;
    home = config.hostSpec.home;
    isNormalUser = true;
    description = config.hostSpec.userFullName;
    hashedPassword = "***REMOVED***";
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
    shell = pkgs.zsh;
    extraGroups = lib.flatten [
      "wheel"
      (ifTheyExist [
        "audio"
        "video"
        "docker"
        "git"
        "networkmanager"
        "scanner" # for print/scan"
        "lp" # for print/scan"
      ])
    ];
  };

  systemd.tmpfiles.rules = [
    "d /persist/${config.hostSpec.username}/ 0777 root root -"
    "d /persist/home/${config.hostSpec.username} 0700 ${config.hostSpec.username} users -"
  ];

  programs.zsh.enable = true;
  programs.git.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit pkgs inputs;
      hostSpec = config.hostSpec;
    };

    users.${config.hostSpec.username}.imports = [
      (lib.custom.relativeToRoot "home/${config.hostSpec.username}/${config.hostSpec.hostName}.nix")
    ];
  };
}
