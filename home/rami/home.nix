{ config, lib, pkgs, inputs, ... }:

{
  home.username = lib.mkDefault "rami";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  home.packages = with pkgs; [
    (import ../../pkgs/zen.nix {
      appimageTools = pkgs.appimageTools;
      fetchurl = pkgs.fetchurl;
    })

    kitty
    yadm
    gh
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}

  # systemd.user.services.yadm-repo-sync = {
  #   Unit = {
  #     Description = "YADM Repo Sync and Submodule Update";
  #     After = [ "default.target" ];  # Ensure service runs after user session starts
  #   };
  #   Install = {
  #     WantedBy = [ "default.target" ];  # Add service to the default target
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.writeShellScript "yadm-repo-sync" ''
  #       #!/run/current-system/sw/bin/bash
  #       cd /persist/home/rami
  #
  #       # Attempt to clone the repository
  #       if ! yadm clone https://github.com/rmenai/dotfiles.git -w /persist/home/rami; then
  #         echo "Repository already exists, attempting to sync..."
  #         # If clone fails (repo exists), sync the repo by pulling, committing, and pushing
  #         yadm pull --recurse-submodules
  #         yadm commit -am "Sync with remote repository"
  #         yadm push
  #       fi
  #
  #       # Ensure submodules are initialized and updated
  #       yadm submodule update --recursive --init
  #     ''}";
  #   };
  # };
