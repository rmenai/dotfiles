{ lib, ... }: {
  meta = { description = "Personal NixOS infrastructure"; };

  defaults = {
    deployment = {
      targetUser = lib.mkDefault "root";
      targetPort = lib.mkDefault 22;

      # Build settings
      buildOnTarget = false;

      # Deployment tags for selective deployment
      tags = [ "nixos" ];
    };
  };
}
