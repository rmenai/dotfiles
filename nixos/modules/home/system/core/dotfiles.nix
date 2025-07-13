{ config, lib, inputs, ... }: {
  options.features.dotfiles = {
    enable = lib.mkEnableOption "dotfiles management";
    paths = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description =
        "Mapping of destination file paths to source subdirectories inside ~/.dotfiles.";
    };
    useFlake = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use the flake input instead of local ~/.dotfiles";
    };
  };

  config = lib.mkIf config.features.dotfiles.enable (let
    flakeFolder = builtins.toString inputs.dotfiles;
    localFolder = "/home/${config.home.username}/.dotfiles";
  in {
    home.file = builtins.mapAttrs (target: file: {
      source = if config.features.dotfiles.useFlake then
        "${flakeFolder}/${file}"
      else
        config.lib.file.mkOutOfStoreSymlink "${localFolder}/${file}";
    }) (lib.filterAttrs (k: v: v != "") config.features.dotfiles.paths);
  });
}
