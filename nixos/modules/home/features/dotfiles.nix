{
  config,
  lib,
  ...
}: {
  options.features.dotfiles = {
    enable = lib.mkEnableOption "dotfiles management";

    paths = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Mapping of destination file paths to source subdirectories inside ~/.dotfiles.";
    };
  };

  config = lib.mkIf config.features.dotfiles.enable {
    home.file = builtins.mapAttrs (target: file: {
      source = config.lib.file.mkOutOfStoreSymlink "/home/${config.spec.user}/.dotfiles/${file}";
    }) (lib.filterAttrs (k: v: v != "") config.features.dotfiles.paths);
  };
}
