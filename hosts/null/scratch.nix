{ config, inputs, ... }:
{
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
