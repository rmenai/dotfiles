{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    whatsapp-for-linux
  ];

  persist = {
    home = {
      ".local/share/whatsapp-for-linux" = lib.mkDefault true;
      ".cache/whatsapp-for-linux" = lib.mkDefault true;
    };
  };
}
