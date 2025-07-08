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

  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  environment.persistence."/persist/system" = {
    directories = [
      "/var/lib/sddm"
      "/usr/share/sddm"
    ];
  };
}
