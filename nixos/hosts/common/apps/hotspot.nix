{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    hostapd
    dnsmasq
    python3
    iw
  ];

  networking.networkmanager.enable = lib.mkForce false;
  networking.useNetworkd = lib.mkForce false;

  networking.interfaces.wlp0s20f3 = {
    useDHCP = false;
    ipv4.addresses = [
      {
        address = "192.168.0.8";
        prefixLength = 24;
      }
    ];
  };

  networking.wireless = {
    enable = true;
    interfaces = ["wlp0s20f3"];
    networks = {
      "Test" = {
        psk = "SuperStrong";
      };
    };
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "wlp0s20f3";
      dhcp-range = ["192.168.0.2,192.168.0.254"];
      dhcp-option = [
        "option:router,${(lib.lists.head config.networking.interfaces.wlp0s20f3.ipv4.addresses).address}"
        "option:dns-server,${(lib.lists.head config.networking.interfaces.wlp0s20f3.ipv4.addresses).address}"
      ];
      address = "/#/${(lib.lists.head config.networking.interfaces.wlp0s20f3.ipv4.addresses).address}";
      no-resolv = true;
    };
  };
}
