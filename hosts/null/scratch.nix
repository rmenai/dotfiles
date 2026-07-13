{

  # zjstatus = {
  #   url = "https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm";
  #   flake = false;
  # };
  #
  # zjnav = {
  #   url = "https://github.com/hiasr/vim-zellij-navigator/releases/latest/download/vim-zellij-navigator.wasm";
  #   flake = false;
  # };
  #   # colmenaHive = inputs.colmena.lib.makeHive self.outputs.colmena;
  #
  # name = "vault";
  #
  # packages = [
  #   inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
  # ];
  #
  # features = {
  #   services = {
  #     tailscale.enable = true;
  #     openssh.enable = true;
  #     ssh.enable = true;
  #   };
  # };
  #
  # features.services = {
  #   libvirt.enable = lib.mkDefault true;
  #   podman.enable = lib.mkDefault true;
  #
  #   waydroid.enable = lib.mkDefault false;
  #   virtualbox.enable = lib.mkDefault false;
  # };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  # };

  # sops.secrets = {
  #   "id_ed25519_vm" = {
  #     key = "users/vault/ssh_private_key";
  #     sopsFile = "${builtins.toString inputs.secrets}/hosts/vm.yaml";
  #     path = "/home/${config.spec.user}/.ssh/id_ed25519_vm";
  #     owner = config.spec.user;
  #     group = "users";
  #     mode = "0600";
  #   };
  #
  #   "id_ed25519_vm.pub" = {
  #     key = "users/vault/ssh_public_key";
  #     sopsFile = "${builtins.toString inputs.secrets}/hosts/vm.yaml";
  #     path = "/home/${config.spec.user}/.ssh/id_ed25519_vm.pub";
  #     owner = config.spec.user;
  #     group = "users";
  #     mode = "0600";
  #   };
  #
  #   "id_ed25519_kernel" = {
  #     key = "users/vault/ssh_private_key";
  #     sopsFile = "${builtins.toString inputs.secrets}/hosts/kernel.yaml";
  #     path = "/home/${config.spec.user}/.ssh/id_ed25519_kernel";
  #     owner = config.spec.user;
  #     group = "users";
  #     mode = "0600";
  #   };
  #
  #   "id_ed25519_kernel.pub" = {
  #     key = "users/vault/ssh_public_key";
  #     sopsFile = "${builtins.toString inputs.secrets}/hosts/kernel.yaml";
  #     path = "/home/${config.spec.user}/.ssh/id_ed25519_kernel.pub";
  #     owner = config.spec.user;
  #     group = "users";
  #     mode = "0600";
  #   };
  # };
}
