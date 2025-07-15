{ lib }: {
  mkColmenaConfig = { commonSpecialArgs, hostsDir, deploymentConfig ? null
    , system ? "x86_64-linux", mkPkgs }:
    let
      # Automatically discover hosts from hostsDir
      hosts = if builtins.pathExists hostsDir then
        lib.filter (name: name != "common")
        (builtins.attrNames (builtins.readDir hostsDir))
      else
        [ ];

      baseConfig =
        if deploymentConfig != null && builtins.pathExists deploymentConfig then
          import deploymentConfig
        else
          { };

      hostConfigs = lib.genAttrs hosts (host: {
        deployment = baseConfig.deployment or { };
        imports = [ (hostsDir + "/${host}") ];
        _module.args.isColmena = true;
      });

      metaConfig = {
        nixpkgs = mkPkgs system;
        specialArgs = commonSpecialArgs;
      } // (baseConfig.meta or { });

      defaultsConfig = baseConfig.defaults or { };
    in {
      meta = metaConfig;
      defaults = defaultsConfig;
    } // hostConfigs;
}
