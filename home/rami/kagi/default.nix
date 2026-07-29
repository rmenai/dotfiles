{ pkgs, ... }: {
  imports = [
    ./core.nix

    ../../../modules/home/cli/git.nix
    ../../../modules/home/cli/ssh.nix

    ../../../modules/home/cli/neovim
    ../../../modules/home/cli/direnv.nix
    ../../../modules/home/cli/atuin.nix
    ../../../modules/home/cli/yazi.nix
    ../../../modules/home/cli/fzf.nix
    ../../../modules/home/cli/zoxide.nix
    ../../../modules/home/cli/bat.nix

    ../../../modules/home/cli/gcc.nix
    ../../../modules/home/cli/rust.nix
    ../../../modules/home/cli/python.nix
    ../../../modules/home/cli/node.nix
  ];

  programs.home-manager.enable = true;
  programs.bash.enable = true;

  home.packages = with pkgs; [
    ripgrep
    curl
  ];

  home = {
    sessionPath = [
      "~/.local/bin"
    ];
  };
}
