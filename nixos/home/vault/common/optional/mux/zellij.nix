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

  persist = {
    home = {
      # ".cache/zellij" = lib.mkDefault true;
    };
  };
}
