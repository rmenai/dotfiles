{
  config,
  inputs,
  lib,
  ...
}:

let
  cfg = config.features.core.dotfiles;
in
{
  options.features.core.dotfiles = {
    enable = lib.mkEnableOption "dotfiles management";

    mutable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "If true, symlink to localRepo. If false, link to inputs.dotfiles (store).";
    };

    localRepo = lib.mkOption {
      type = lib.types.str;
      default = "/home/${config.spec.user}/.dotfiles";
      description = "Path to the local git repository for mutable editing.";
    };

    repoUrl = lib.mkOption {
      type = lib.types.str;
      default = "https://github.com/rmenai/dotfiles.git";
      description = "URL to clone if the local repo is missing (only in mutable mode).";
    };

    # Usage: { "nvim" = "nvim"; "hypr" = "hypr/conf"; }
    links = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Map of .config folder names to paths relative to the dotfiles repo.";
    };

    homeLinks = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Map: ~/<name> -> <dotfiles-repo>/<value>";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = lib.mapAttrs (name: sourcePath: {
      source =
        if cfg.mutable then
          config.lib.file.mkOutOfStoreSymlink "${cfg.localRepo}/${sourcePath}"
        else
          "${inputs.dotfiles}/${sourcePath}";
    }) cfg.links;

    home.file = lib.mapAttrs (name: sourcePath: {
      source =
        if cfg.mutable then
          config.lib.file.mkOutOfStoreSymlink "${cfg.localRepo}/${sourcePath}"
        else
          "${inputs.dotfiles}/${sourcePath}";
    }) cfg.homeLinks;
  };
}
