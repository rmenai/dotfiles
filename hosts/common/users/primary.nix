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

  environment.persistence."/persist" = {
    users.${config.hostSpec.username} = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        ".dotfiles"
        ".gnupg"
        ".ssh"
        ".nixops"
        ".cargo"
        ".rustup"
        ".opam"
        ".cache"
        ".local/share/keyrings"
        ".local/share/direnv"
        ".local/share/hyprland"
        ".local/share/nvim"
        ".local/share/sddm"
        ".local/share/zinit"
        ".local/share/zoxide"
        ".local/share/tmux"
        ".local/state/home-manager"
        ".local/state/nix"
        ".local/state/nvim"
        ".local/state/containers"
        ".config/gh"
        ".config/obsidian"
        ".config/BraveSoftware"
      ];
    };
  };
}
