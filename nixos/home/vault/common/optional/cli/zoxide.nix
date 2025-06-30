{lib, ...}: {
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  persist = {
    home = {
      # ".local/share/zoxide" = lib.mkDefault true;
    };
  };
}
