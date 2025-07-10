{lib, ...}: {
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  features.dotfiles = {
    paths = {
      ".config/zellij" = lib.mkDefault "zellij";
    };
  };
