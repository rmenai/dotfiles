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

  features.persist = {
    directories = {
      "/var/lib/sddm" = true;
      "/usr/share/sddm" = true;
    };
  };
}
