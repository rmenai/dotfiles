{ lib }:
{
  mkNixosConfigurations =
    {
      hosts,
      commonSpecialArgs,
      hostsDir,
    }:
    lib.genAttrs hosts (
      host:
      lib.nixosSystem {
        specialArgs = commonSpecialArgs;
        modules = [
          ../modules/common/deployment.nix # Need to put it here for colmena to work
          (hostsDir + "/${host}")
        ];
      }
    );
}
