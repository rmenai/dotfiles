{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    yazi
    p7zip
    poppler
    jq
    fd
  ];

  dotfiles = {
    files = {
      ".config/yazi" = lib.mkDefault "yazi";
    };
  };

  persist = {
    home = {
      # ".local/state/yazi" = lib.mkDefault true;
    };
  };
}
