{config, ...}: {
  imports = [
    ../common
    ./dotfiles
    ../features/cli
    ../features/dev
    ./home.nix
    ./impermanence.nix
  ];

  # features = {
  #   cli = {
  #     nvim.enable = true;
  #     zsh.enable = true;
  #   };
  # };
}
