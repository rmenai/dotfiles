
    # mkHomeConfig = host: let
    #   user = hostUserMap.${host} or (throw "User not defined for host ${host} in hostUserMap");
    #   system = "x86_64-linux";
    #   pkgs = import nixpkgs {
    #     inherit system;
    #     overlays = [self.overlays.default];
    #     config = {
    #       allowUnfree = true;
    #     };
    #   };
    # in {
    #   "${user}@${host}" = home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;
    #     extraSpecialArgs = {
    #       inherit inputs outputs;
    #     };
    #     modules = [
    #       ./home/${user}/${host}.nix
    #     ];
    #   };
    # };
    # mkHomeConfigs = hosts: lib.foldl (acc: set: acc // set) {} (lib.map mkHomeConfig hosts);

    homeConfigurations = mkHomeConfigs (lib.attrNames hostUserMap);

    #
    # formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    # checks = forAllSystems (
    #   system: let
    #     pkgs = nixpkgs.legacyPackages.${system};
    #   in
    #     import ./checks.nix {inherit inputs system pkgs;}
    # );
    #
    # devShells = forAllSystems (system: {
    #   default = nixpkgs.legacyPackages.${system}.mkShell {
    #     inherit (self.checks.${system}.pre-commit-check) shellHook;
    #     buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
    #   };
    # });

    # hostUserMap = {
    #   "null" = "vault";
    #   "kali" = "vault";
    #   "ubuntu" = "vault";
    # };
