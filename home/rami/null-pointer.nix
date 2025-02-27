{config, ...}: {
  imports = [
    ../features/cli
    ../features/dev
    ../common
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
