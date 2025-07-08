{
  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };

      autoLogin = {
        enable = true;
        user = "vault";
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
