{pkgs, ...}: {
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

  home.packages = with pkgs; [
    ripgrep
    wl-clipboard
    xclip
    xsel
    undollar
    btop
    unzip
    zip
  ];
}
