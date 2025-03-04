{
  inputs,
  outputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops

    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/hosts/common"

      "hosts/common/core/services"
      "hosts/common/core/sops.nix"
      "hosts/common/core/ssh.nix"
    ])
  ];

  hostSpec = {
    username = "rami";
    handle = "rmenai";
    userFullName = "Rami Menai";
    email = "rami@menai.me";
  };

  networking.hostName = config.hostSpec.hostName;

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
    backupFileExtension =
      "backup-"
      + pkgs.lib.readFile
      "${pkgs.runCommand "timestamp" {} "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";
  };

  nixpkgs = {
    overlays = [outputs.overlays.default];
    config.allowUnfree = true;
  };

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      connect-timeout = 5;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      trusted-users = [
        "root"
        config.hostSpec.username
      ];
      auto-optimise-store = true;
      warn-dirty = false;

      allow-import-from-derivation = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    optimise.automatic = true;
  };

  security.sudo.extraConfig = ''
    Defaults lecture = never # rollback results in sudo lectures after each reboot
    Defaults timestamp_timeout=120 # only ask for password every 2h
  '';

  environment = {
    systemPackages = with pkgs; [
      wget
      git
      vim
    ];
  };

  time.timeZone = lib.mkDefault "Europe/Paris";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
}
