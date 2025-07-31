{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = { url = "github:nix-community/impermanence"; };
    catppuccin.url = "github:catppuccin/nix";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets = {
      url = "git+ssh://git@github.com/rmenai/secrets.git?ref=main&shallow=1";
      flake = false;
    };

    curd = {
      url = "github:Wraient/curd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      url = "github:nix-community/nh/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, colmena, home-manager, ... }@inputs:
    let
      lib = import ./lib { inherit (nixpkgs) lib inputs; };

      systems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      forEachSystem = f: forAllSystems (system: f system);

      hosts = lib.discoverHosts ./hosts;
      miscHosts = lib.discoverHosts ./misc;

      extendedLib = nixpkgs.lib.extend (self: super: { custom = lib; });

      # Create pkgs with overlays for each system
      mkPkgs = system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };

      commonSpecialArgs = {
        inherit inputs;
        outputs = self;
        func = extendedLib;
      };
    in {
      inherit inputs;

      nixosConfigurations = lib.mkNixosConfigurations {
        inherit hosts commonSpecialArgs;
        hostsDir = ./hosts;
      } // lib.mkNixosConfigurations {
        inherit commonSpecialArgs;
        hosts = miscHosts;
        hostsDir = ./misc;
      };

      homeConfigurations = lib.mkHomeConfigurations {
        inherit hosts home-manager commonSpecialArgs systems;
        homeDir = ./home;
        mkPkgs = mkPkgs;
      };

      colmena = lib.mkColmenaConfig {
        inherit commonSpecialArgs mkPkgs;
        hostsDir = ./hosts;
        deploymentConfig = ./deployment.nix;
        system = "x86_64-linux";
      };

      overlays = import ./overlays { inherit inputs; };

      packages = forEachSystem (system:
        let
          pkgs = mkPkgs system;
          pkgsFromDir = nixpkgs.lib.packagesFromDirectoryRecursive {
            callPackage = pkgs.callPackage;
            directory = ./pkgs;
          };

          extraPackages = {
            microvm =
              self.nixosConfigurations.microvm.config.microvm.declaredRunner;
            vm = self.nixosConfigurations.vm.config.system.build.vm;
            null = self.nixosConfigurations.null.config.system.build.vm;
            fork = self.nixosConfigurations.fork.config.system.build.vm;
          };

          extraImages = {
            virtualbox = inputs.nixos-generators.nixosGenerate {
              system = "x86_64-linux";
              format = "virtualbox";
            };

            vagrant-virtualbox = inputs.nixos-generators.nixosGenerate {
              system = "x86_64-linux";
              format = "vagrant-virtualbox";
            };

            qcow = inputs.nixos-generators.nixosGenerate {
              system = "x86_64-linux";
              format = "qcow";
            };

            qcow-efi = inputs.nixos-generators.nixosGenerate {
              system = "x86_64-linux";
              format = "qcow-efi";
            };

            do = inputs.nixos-generators.nixosGenerate {
              system = "x86_64-linux";
              format = "do";
            };

            docker = inputs.nixos-generators.nixosGenerate {
              system = "x86_64-linux";
              format = "docker";
            };

            iso = inputs.nixos-generators.nixosGenerate {
              system = "x86_64-linux";
              format = "iso";
            };

            install-iso = inputs.nixos-generators.nixosGenerate {
              system = "x86_64-linux";
              format = "install-iso";
            };
          };

        in pkgsFromDir // extraPackages // extraImages);
    };
}
