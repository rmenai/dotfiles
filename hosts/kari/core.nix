{
  inputs,
  outputs,
  pkgs,
  ...
}:
let
  secrets = builtins.toString inputs.secrets;
in
{
  imports = [
    inputs.nix-index-database.nixosModules.nix-index
    inputs.home-manager.nixosModules.home-manager
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.catppuccin.nixosModules.catppuccin
    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.disko

    "${inputs.secrets}/nixos.nix"
  ];

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.extraConfig = ''
    Defaults !tty_tickets
    Defaults lecture = never
    Defaults timestamp_timeout=120
  '';

  boot.supportedFilesystems = [ ];
  system.stateVersion = "26.05";

  nixpkgs = {
    overlays = [ outputs.overlays.default ];
    config.allowUnfree = true;
  };

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs pkgs; };
    users.rami = import ../../home/rami/kari/default.nix;
  };

  sops = {
    defaultSopsFile = "${secrets}/hosts/kari.yaml";
    validateSopsFiles = true;

    gnupg.sshKeyPaths = [ ];

    age = {
      keyFile = "/var/lib/sops/key.txt";
      generateKey = false;
      sshKeyPaths = [ ];
    };
  };

  environment.systemPackages = with pkgs; [
    inputs.colmena.packages.${pkgs.system}.colmena
    sops
    age

    fastfetch
    curl
    vim
    git
    zip
    unzip
  ];

  programs = {
    nix-index-database.comma.enable = true;
  };
}
