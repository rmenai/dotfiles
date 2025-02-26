{
  config,
  pkgs,
  inputs,
  ...
}:

{
  systemd.tmpfiles.rules = [
    "d /persist/home/ 0777 root root -"
    "d /persist/home/rami 0700 rami users -"
  ];

  users.users.rami = {
    isNormalUser = true;
    description = "Rami Menai";
    hashedPassword = "Redecated";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };

  home-manager.users.rami = import ../../../home/rami/${config.networking.hostName}.nix;
}

