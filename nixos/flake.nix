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

    nix-secrets = {
      url = "git+ssh://git@github.com/rmenai/nix-secrets.git?ref=main&shallow=1";
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

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;

    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];

    readHosts = lib.filter (name: name != "common") (lib.attrNames (builtins.readDir ./hosts));

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
  in {
    nixosConfigurations = mkHostConfigs readHosts;

    overlays = import ./overlays {inherit inputs;};
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
  };
}
