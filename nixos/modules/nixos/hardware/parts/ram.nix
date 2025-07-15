{ config, lib, ... }: {
  options.features.hardware.ram = { enable = lib.mkEnableOption "Zram"; };

  config = lib.mkIf config.features.hardware.ram.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 30;
    };
  };
}
