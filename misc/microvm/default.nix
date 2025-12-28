{ func, lib, ... }:
{
  # imports = lib.flatten [
  #   (map func.custom.relativeToRoot [ "modules/common" ])
  #   (map func.custom.relativeToRoot [ "modules/nixos" ])
  #
  #   ./hardware.nix
  #   ./networking.nix
  #   ./variants.nix
  # ];
  #
  # spec = {
  #   host = "microvm";
  #   timeZone = "Europe/Paris";
  #   defaultLocale = "en_US.UTF-8";
  # };
  #
  # features = {
  #   profiles.core.enable = true;
  #   users.alice.enable = true;
  #
  #   system.nix.enable = true;
  #   services.networking.openssh.enable = true;
  #   apps.core.enable = true;
  # };
}
