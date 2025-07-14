{ config, inputs, lib, pkgs, ... }: {
  options.features.users.vault = {
    enable = lib.mkEnableOption "vault user configuration";
  };

  config = lib.mkIf config.features.users.vault.enable {
    sops.secrets."users/vault/password_hash".neededForUsers = true;
    users.mutableUsers = false;

    spec = {
      user = "vault";
      handle = "rmenai";
      userFullName = "Rami Menai";
      email = "rami@menai.me";
    };

    users.users.${config.spec.user} = {
      name = config.spec.user;
      home = "/home/${config.spec.user}";
      isNormalUser = true;
      description = config.spec.userFullName;
      hashedPasswordFile = config.sops.secrets."users/vault/password_hash".path;
      packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
      shell = pkgs.nushell;
      extraGroups = lib.flatten [ "wheel" "input" ];
    };
  };
}
