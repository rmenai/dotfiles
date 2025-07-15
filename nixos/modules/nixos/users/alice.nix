{ config, inputs, lib, pkgs, ... }: {
  options.features.users.alice = {
    enable = lib.mkEnableOption "alice user configuration";
  };

  config = lib.mkIf config.features.users.alice.enable {
    users.mutableUsers = false;

    spec = {
      user = "alice";
      handle = "rmenai";
      userFullName = "Rami Menai";
      email = "rami@menai.me";
    };

    users.users.${config.spec.user} = {
      name = config.spec.user;
      home = "/home/${config.spec.user}";
      isNormalUser = true;
      description = config.spec.userFullName;
      password = "test";
      packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
      shell = pkgs.bash;
      extraGroups = lib.flatten [ "wheel" "input" ];
    };
  };
}
