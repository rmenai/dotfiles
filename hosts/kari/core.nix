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

    # Launch any app using the void user
    (pkgs.writeShellScriptBin "void-rofi" ''
      ${pkgs.xhost}/bin/xhost +SI:localuser:void
      ${pkgs.acl}/bin/setfacl -m u:void:x "$XDG_RUNTIME_DIR" 2>/dev/null || true
      ${pkgs.acl}/bin/setfacl -m u:void:rw "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" 2>/dev/null || true

      su - void -c "mkdir -p /tmp/void-run && chmod 0700 /tmp/void-run && env DISPLAY=\"$DISPLAY\" WAYLAND_DISPLAY=\"$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY\" XDG_RUNTIME_DIR=\"/tmp/void-run\" rofi -show drun"
    '')
  ];

  programs = {
    nix-index-database.comma.enable = true;
  };
}
