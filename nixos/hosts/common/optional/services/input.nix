{
  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    libinput.enable = true;
  };
}
