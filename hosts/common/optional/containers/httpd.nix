{
  containers.httpd = {
    autoStart = true;
    config = {...}: {
      services.httpd = {
        enable = true;
        adminAddr = "foo@example.org";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [80];
}
