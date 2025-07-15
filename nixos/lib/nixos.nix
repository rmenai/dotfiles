{ lib }: {
  mkNixosConfigurations = { hosts, commonSpecialArgs, hostsDir }:
    lib.genAttrs hosts (host:
      lib.nixosSystem {
        specialArgs = commonSpecialArgs;
        modules = [ ../modules/common/deployment.nix (hostsDir + "/${host}") ];
      });
}
