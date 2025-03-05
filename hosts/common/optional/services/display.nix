{
  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };

  environment.persistence."/persist/system" = {
    directories = [
      "/var/lib/sddm"
      "/usr/share/sddm"
    ];
  };
}
