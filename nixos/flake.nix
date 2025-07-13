{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = { url = "github:nix-community/impermanence"; };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url =
        "git+ssh://git@github.com/rmenai/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };

    dotfiles = {
      url =
        "git+ssh://git@github.com/rmenai/dotfiles.git?ref=main&submodules=1";
      flake = false;
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    curd = {
      url = "github:Wraient/curd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;

      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];

      readHosts = lib.filter (name: name != "common")
        (lib.attrNames (builtins.readDir ./hosts));

      # Extended lib with custom functions
      extendedLib = nixpkgs.lib.extend
        (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });

      mkHost = host: {
        ${host} = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            func = extendedLib;
          };
          modules = [ ./hosts/${host} ];
        };
      };

      mkHostConfigs = hosts:
        lib.foldl (acc: set: acc // set) { } (lib.map mkHost hosts);

      # Function to create home-manager configurations
      # This creates configurations for each user@host combination
      mkHomeConfig = host:
        let
          # Read the host directory to find available home configurations
          homeDir = ./home;
          availableUsers = if builtins.pathExists homeDir then
            lib.attrNames (builtins.readDir homeDir)
          else
            [ ];

          # Create configs for each user that has a config for this host
          userConfigs = lib.genAttrs
            (lib.filter (user: builtins.pathExists ./home/${user}/${host}.nix)
              availableUsers) (user:
                home-manager.lib.homeManagerConfiguration {
                  pkgs = nixpkgs.legacyPackages.x86_64-linux;
                  extraSpecialArgs = {
                    inherit inputs outputs;
                    func = extendedLib;
                  };
                  modules = [ ./home/${user}/${host}.nix ];
                });
          # Rename keys to user@host format
        in lib.mapAttrs' (user: config: {
          name = "${user}@${host}";
          value = config;
        }) userConfigs;

      mkHomeConfigs = hosts:
        lib.foldl (acc: set: acc // set) { } (lib.map mkHomeConfig hosts);

    in {
      nixosConfigurations = mkHostConfigs readHosts;

      # Add home-manager configurations
      homeConfigurations = mkHomeConfigs readHosts;

      overlays = import ./overlays { inherit inputs; };
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith pkgs;
          directory = ./pkgs;
        });
    };
}
