{ config, lib, pkgs, ... }: {
  options.features.apps.core = { enable = lib.mkEnableOption "Core apps"; };

  config = lib.mkIf config.features.apps.core.enable {
    environment.systemPackages = with pkgs; [ fastfetch wget curl vim git gh ];

    programs.command-not-found.enable = true;
    programs.zsh.enable = true;

    programs.ssh = {
      startAgent = true;

      enableAskPassword = true;
      askPassword =
        "${pkgs.wofi}/bin/wofi --dmenu --password --prompt='SSH Password: '";

      knownHostsFiles = [
        (pkgs.writeText "custom_known_hosts" ''
          github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
          github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
        '')
      ];
    };

    home-manager.users.root = {
      home.stateVersion = config.system.stateVersion;
      programs.git = {
        enable = true;
        extraConfig.safe.directory = "/home/${config.spec.user}/.dotfiles";
      };
    };

    users.users.${config.spec.user}.extraGroups = [ "git" ];
  };
}
