{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.persistence."/persist/home/rami" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".local/share/keyrings"
      ".local/share/direnv"
      ".local/share/yadm"
    ];
    allowOther = true;
  };

  home.packages = with pkgs; [
    yadm
    gh
  ];

  programs.git = {
    enable = true;
    userName = "Rami Menai";
    userEmail = "rami@menai@menai.me";
  };

  systemd.user.services.yadm-repo-sync = {
    Unit = {
      Description = "YADM Repo Sync and Submodule Update";
      After = [ "default.target" ];  # Ensure service runs after user session starts
    };
    Install = {
      WantedBy = [ "default.target" ];  # Add service to the default target
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "yadm-repo-sync" ''
        #!/run/current-system/sw/bin/bash
        cd /persist/home/rami

        # Attempt to clone the repository
        if ! yadm clone https://github.com/rmenai/dotfiles.git -w /persist/home/rami; then
          echo "Repository already exists, attempting to sync..."
          # If clone fails (repo exists), sync the repo by pulling, committing, and pushing
          yadm pull --recurse-submodules
          yadm commit -am "Sync with remote repository"
          yadm push
        fi

        # Ensure submodules are initialized and updated
        yadm submodule update --recursive --init
      ''}";
    };
  };
}
