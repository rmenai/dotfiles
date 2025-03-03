{
  config,
  lib,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      autoLogin = {
        enable = true;
        user = config.hostSpec.username;
      };
    };

    libinput.enable = true;
    fstrim.enable = lib.mkDefault true;
  };
}
