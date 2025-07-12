{ pkgs, lib, config, ... }: {
  options.features.apps.shell.nushell = {
    enable = lib.mkEnableOption "Nushell shell";
  };

  config = lib.mkIf config.features.apps.shell.nushell.enable {
    home.packages = with pkgs; [ nushell ];

    programs.carapace.enable = true;
    programs.starship.enable = true;

    features.dotfiles = {
      paths = {
        ".config/nushell" = lib.mkDefault "nushell";
        ".config/starship.toml" = lib.mkDefault "starship.toml";
        ".profile" = lib.mkDefault "shell/.profile";
      };
    };
  };
}
