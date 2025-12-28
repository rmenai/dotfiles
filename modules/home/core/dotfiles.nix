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
      description = "If true, symlink to localRepo. If false, use the Nix Store.";
    };

    root = lib.mkOption {
      type = lib.types.str;
      default = "/home/${config.spec.user}/.dotfiles";
      description = "Absolute path to the local dotfiles root (used only in mutable mode).";
    };

    mkLink = lib.mkOption {
      readOnly = true;
      description = "Link a file/folder based on the mutable toggle. Usage: mkLink ./filename";
      default =
        path:
        let
          pathStr = toString path;
          rootStr = toString inputs.self;
          relativePath = lib.removePrefix rootStr pathStr;
        in
        if cfg.mutable then config.lib.file.mkOutOfStoreSymlink "${cfg.root}${relativePath}" else path;
    };
  };
}
