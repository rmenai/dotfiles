{lib, ...}: {
  options.persist = {
    home = lib.mkOption {
      type = lib.types.attrsOf lib.types.bool;
      default = {
        "Downloads" = true;
        "Music" = true;
        "Pictures" = true;
        "Documents" = true;
        "Videos" = true;
        ".dotfiles" = true;
        ".gnupg" = true;
        ".ssh" = true;
        ".nixops" = true;
        ".cache" = true;
      };
      description = ''
        Mapping of home directories (relative paths) to a boolean.
        Set to true to enable persistence, false to disable.
      '';
    };
  };

  config = {};
}
