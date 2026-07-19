{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  # networking.nat = {
  #   enable = true;
  #   internalInterfaces = [ "ve-+" ];
  #   externalInterface = "wlan0";
  # };
  #
  containers.secure = {
    autoStart = true;
    privateNetwork = true; # Force separate network namespace
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";

    bindMounts = {
      "/home/void" = {
        hostPath = "/home/void";
        isReadOnly = false;
      };

      "/tmp/wayland-1" = {
        hostPath = "/run/user/1000/wayland-1";
        isReadOnly = false;
      };

      "/dev/dri" = {
        hostPath = "/dev/dri";
        isReadOnly = false;
      };

      "/run/opengl-driver" = {
        hostPath = "/run/opengl-driver";
        isReadOnly = true;
      };
    };

    config = { config, pkgs, ... }: {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.catppuccin.nixosModules.catppuccin
      ];

      time.timeZone = "Europe/Paris";
      system.stateVersion = "26.05";
      nixpkgs.config.allowUnfree = true;

      environment.variables = {
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        GDK_BACKEND = "wayland,x11";
      };

      # # networking.networkmanager.enable = true;
      # # services.gnome.gnome-keyring.enable = true; # Remembers Proton login

      users.users.void = {
        isNormalUser = true;
        uid = 1001;
        home = "/home/void";
        extraGroups = [
          "networkmanager"
          "video"
          "audio"
        ];
      };

      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        extraSpecialArgs = { inherit inputs outputs pkgs; };
        users.void = import ../../../../home/void/kari.nix;
      };

      environment.systemPackages = with pkgs; [
        curl
        # proton-vpn
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "secure-askpass" ''
      exec rofi -dmenu -password -p "Secure Folder Password:" -lines 0
    '')

    (writeShellScriptBin "secure-run" ''
      if [ "$EUID" -eq 0 ]; then
        echo "Error: Do not run this wrapper with sudo. Run it as your normal user."
        exit 1
      fi

      CMD=$(printf "%q " "$@")
      export SUDO_ASKPASS="/run/current-system/sw/bin/secure-askpass"

      sudo -k

      sudo -A ${pkgs.bash}/bin/bash -c "
        /run/current-system/sw/bin/setfacl -m u:1001:rw /run/user/1000/wayland-1
        exec /run/current-system/sw/bin/nixos-container run secure -- su - void -c \"env WAYLAND_DISPLAY=/tmp/wayland-1 $CMD\"
      "
    '')
  ];

  security.sudo.extraConfig = ''
    # Block an attacker from manually running the container using an active terminal ticket
    Defaults!/run/current-system/sw/bin/nixos-container timestamp_timeout=0
  '';
}
