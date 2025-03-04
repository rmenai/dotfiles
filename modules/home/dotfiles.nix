{
  config,
  lib,
  ...
}: {
  options.dotfiles.files = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = {};
    description = "Mapping of destination file paths to source subdirectories inside ~/.dotfiles.";
  };

  config = {
    home.file = builtins.mapAttrs (target: file: {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/${file}";
    }) (lib.filterAttrs (k: v: v != "") config.dotfiles.files);
  };
}
