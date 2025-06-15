{lib, ...}: {
  persist = {
    home = {
      ".steam" = lib.mkDefault true;
      ".local/share/Steam" = lib.mkDefault true;
      ".local/share/vulkan" = lib.mkDefault true;
      ".config/itch" = lib.mkDefault true;
      ".config/unity3d" = lib.mkDefault true;
    };
  };
}
