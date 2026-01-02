{ lib }:
{
  mkColmenaConfig =
    {
      commonSpecialArgs,
      hostsDir,
      system ? "x86_64-linux",
      mkPkgs,
    }:
    let
      # Automatically discover hosts from hostsDir
      hosts =
        if builtins.pathExists hostsDir then
          lib.filter (name: name != "common") (builtins.attrNames (builtins.readDir hostsDir))
        else
          [ ];

      hostConfigs = lib.genAttrs hosts (host: {
        deployment = { };
        imports = [ (hostsDir + "/${host}") ];
      });

      metaConfig = {
        nixpkgs = mkPkgs system;
        specialArgs = commonSpecialArgs;
        description = "Personal NixOS infrastructure";
      };

      defaultsConfig = {
        deployment = {
          targetUser = lib.mkDefault "root";
          targetPort = lib.mkDefault 22;

          # Build settings
          buildOnTarget = false;

          # Deployment tags for selective deployment
          tags = [ "nixos" ];
        };
      };
    in
    {
      meta = metaConfig;
      defaults = defaultsConfig;
    }
    // hostConfigs;
}
