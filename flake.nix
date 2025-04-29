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

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "git+ssh://git@github.com/rmenai/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;

    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];

    hostUserMap = {
      "null" = "rami";
    };

    mkHost = host: {
      ${host} = lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          lib = nixpkgs.lib.extend (self: super: {custom = import ./lib {inherit (nixpkgs) lib;};});
        };
        modules = [./hosts/${host}];
      };
    };

    mkHostConfigs = hosts: lib.foldl (acc: set: acc // set) {} (lib.map mkHost hosts);
    readHosts = lib.attrNames (builtins.readDir ./hosts);

    mkHomeConfig = host: let
      user = hostUserMap.${host} or (throw "User not defined for host ${host} in hostUserMap");
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
      };
    in {
      "${user}@${host}" = home-manager.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./home/${user}/${host}.nix
        ];
      };
    };

    mkHomeConfigs = hosts: lib.foldl (acc: set: acc // set) {} (lib.map mkHomeConfig hosts);
  in {
    overlays = import ./overlays {inherit inputs;};
    nixosConfigurations = mkHostConfigs readHosts;
    homeConfigurations = mkHomeConfigs readHosts;

    packages = forAllSystems (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [self.overlays.default];
        };
      in
        lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith pkgs;
          directory = ./pkgs;
        }
    );

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    checks = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./checks.nix {inherit inputs system pkgs;}
    );

    devShells = forAllSystems (system: {
      default = nixpkgs.legacyPackages.${system}.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
      };
    });
  };
}
