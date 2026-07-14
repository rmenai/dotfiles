{
  config,
  inputs,
  lib,
  ...
}:
{
  options.dotfiles = {
    mutable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "If true, symlink to localRepo. If false, use the Nix Store.";
    };

    root = lib.mkOption {
      type = lib.types.str;
      default = "/home/${config.home.homeDirectory}/.dotfiles";
    };

    mkLink = lib.mkOption {
      readOnly = true;
      description = "Link a file/folder based on the mutable toggle.";
      default =
        path:
        let
          pathStr = toString path;
          rootStr = toString inputs.self;
          relativePath = lib.removePrefix rootStr pathStr;
        in
        if config.dotfiles.mutable then
          config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.root}${relativePath}"
        else
          path;
    };
  };
}
