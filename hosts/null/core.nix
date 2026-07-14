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

  boot.supportedFilesystems = [ "ntfs" ];
  system.stateVersion = "25.11";

  nixpkgs = {
    overlays = [ outputs.overlays.default ];
    config.allowUnfree = true;
  };

  sops = {
    defaultSopsFile = "${secrets}/hosts/null.yaml";
    validateSopsFiles = true;

    gnupg.sshKeyPaths = [ ];

    age = {
      keyFile = "/var/lib/sops/key.txt";
      generateKey = false;
      sshKeyPaths = [ ];
    };
  };

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs pkgs; };
    users.vault = import ../../home/vault/null/default.nix;
  };

  environment.systemPackages = with pkgs; [
    sops
    age

    magic-wormhole-rs
    fastfetch
    curl
    vim
    git
    zip
    unzip

    inputs.colmena.packages.${pkgs.system}.colmena
    fastfetch
  ];

  programs = {
    nix-index-database.comma.enable = true;
  };
}
