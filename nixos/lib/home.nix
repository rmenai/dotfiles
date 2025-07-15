{ lib }: {
  mkHomeConfigurations =
    { hosts, commonSpecialArgs, homeDir, systems, mkPkgs, home-manager }:
    let
      # Get all users who have home configs
      availableUsers = if builtins.pathExists homeDir then
        lib.attrNames (builtins.readDir homeDir)
      else
        [ ];

      # Create configs for each user that has a config for this host
      mkHomeConfigsForSystem = system:
        let
          pkgs = mkPkgs system;

          mkHomeConfig = host:
            let
              userConfigs = lib.genAttrs (lib.filter
                (user: builtins.pathExists (homeDir + "/${user}/${host}.nix"))
                availableUsers) (user:
                  home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    extraSpecialArgs = commonSpecialArgs // { inherit system; };
                    modules = [ (homeDir + "/${user}/${host}.nix") ];
                  });
            in lib.mapAttrs' (user: config: {
              name = "${user}@${host}";
              value = config;
            }) userConfigs;

          mkHomeConfigs = hosts:
            lib.foldl (acc: set: acc // set) { } (lib.map mkHomeConfig hosts);
        in mkHomeConfigs hosts;

      # Merge all systems into a single attribute set
      allConfigs =
        lib.foldl (acc: system: acc // (mkHomeConfigsForSystem system)) { }
        systems;
    in allConfigs;
}
