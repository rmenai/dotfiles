{
  lib,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./users
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [
        "root"
        "rami"
      ]; # Set users that are allowed to use the flake command
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    optimise.automatic = true;
    registry =
      (lib.mapAttrs (_: flake: {inherit flake;}))
      ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    nixPath = ["/etc/nix/path"];
  };
}
