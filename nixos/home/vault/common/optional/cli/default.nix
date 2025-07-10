{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./bat.nix
    ./fzf.nix
    ./neofetch.nix
    ./yazi.nix
    ./zoxide.nix
    ./neovim.nix
  ];

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.ncspot.enable = true;

  home.packages = with pkgs; [
    ripgrep
    xclip
    xsel
    unzip
    zip

    btop
    bottom
    bandwhich

    tokei
    ripgrep-all
    atuin
  ];

  features.dotfiles = {
    paths = {
      ".config/btop" = lib.mkDefault "btop";
      ".config/atuin" = lib.mkDefault "atuin";
    };
  };
}
