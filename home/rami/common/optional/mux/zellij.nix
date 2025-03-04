{lib, ...}: {
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  dotfiles = {
    files = {
      ".config/zellij" = lib.mkDefault "zellij";
    };
  };
}
