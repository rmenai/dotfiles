{ lib }: {
  mkNixosConfigurations = { hosts, commonSpecialArgs, hostsDir }:
    lib.genAttrs hosts (host:
      lib.nixosSystem {
        specialArgs = commonSpecialArgs;
        modules = [ (hostsDir + "/${host}") ];
      });
}
