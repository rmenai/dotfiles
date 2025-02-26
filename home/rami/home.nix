{ config, pkgs, inputs, ... }:

{
  home.username = lib.mkDefault "rami";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  home.packages = with pkgs; [
    neovim
    yadm
    gh
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    userName = "Rami Menai";
    userEmail = "rami@menai.me";
  };

  programs.home-manager.enable = true;

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
}
