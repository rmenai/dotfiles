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
    btop
    unzip
    zip

    tokei
    ripgrep-all
    atuin
  ];

  dotfiles = {
    files = {
      ".config/btop" = lib.mkDefault "btop";
    };
  };
}
