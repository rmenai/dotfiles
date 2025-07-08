{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    nushell
  ];

  programs.carapace.enable = true;
  programs.starship.enable = true;

  dotfiles = {
    files = {
      ".config/nushell" = lib.mkDefault "nushell";
      ".config/starship.toml" = lib.mkDefault "starship.toml";
    };
  };
}
