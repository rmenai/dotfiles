{ config, lib, ... }:
let
  cfg = config.features.profiles.core;
in
{
  options.features.profiles.core = {
    enable = lib.mkEnableOption "Core profile";
  };

  config = lib.mkIf cfg.enable {
    features = {
      core = {
        nix.enable = true;
        home.enable = true;
        sops.enable = true;
      };

      apps.tools = {
        git.enable = true;
        ssh.enable = true;
      };
    };

    home.persistence."${config.spec.persistFolder}" = {
      directories = [
        "Downloads"
        "Documents"
        "Pictures"
        "Videos"
        "Public"
        "Games"
        "Music"

        ".ssh"
        ".gnupg"
        ".nixops"

        ".dotfiles"
        ".config"
        ".local"
        ".cache"

        ".ollama"
        ".rustup"
        ".cargo"
        ".volta"
        ".opam"
        ".bun"

        ".vagrant.d"
        ".vimgolf"
        ".steam"
      ];
      files = [
        ".bash_history"
        ".adventofcode.session"
      ];
    };

    home.shellAliases = {
      hibernate = "systemctl hibernate";
      suspend = "systemctl suspend";

      ll = "ls -l";
      la = "ls -a";

      warp = "wormhole-rs";
    };

    home.sessionPath = [
      "~/.local/bin"
    ];
  };
}
