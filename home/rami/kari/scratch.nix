{ pkgs, ... }: {
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.kdePackages.xdg-desktop-portal-kde # Si vous utilisez KDE / Qt
  #     # pkgs.xdg-desktop-portal-gtk          # Décommentez si besoin d'un fallback GTK
  #   ];
  #   config.common.default = "*";
  # };
  #
  # gtk.enable = true; # Même sous Niri/Wayland, active la gestion des types Mime XDG
  #
  # xdg = {
  #   enable = true;
  #   mimeApps.enable = true;
  # };
  # systemd.user.startServices = "sd-switch";
  #
  # home.sessionVariables = {
  #   KDEDIRS = "${pkgs.kdePackages.dolphin}";
  #   XDG_DATA_DIRS = "${pkgs.kdePackages.dolphin}/share:$XDG_DATA_DIRS";
  # };

  #   Host kali
  #     HostName kali
  #     User rami
  #     IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519_vm
  #     ForwardAgent yes
  #     ForwardX11 yes
  #     ForwardX11Trusted yes
  #
  #   Host flare
  #     HostName flare
  #     User rami
  #     IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519_vm
  #     ForwardAgent yes
  #
  #   Host vm
  #     HostName vm
  #     User rami
  #     IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519_vm
  #     ForwardAgent yes
  #     ForwardX11 yes
  #     ForwardX11Trusted yes
  #
  #   Host kernel
  #     HostName kernel
  #     User rami
  #     IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519
  #     ForwardAgent yes
  #     ForwardX11 yes
  #     ForwardX11Trusted yes
  # '';
}
