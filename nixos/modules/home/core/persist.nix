{lib, ...}: {
  options.persist = {
    home = lib.mkOption {
      type = lib.types.attrsOf lib.types.bool;
      default = {};
      description = ''
        Mapping of home directories (relative paths) to a boolean.
        Set to true to enable persistence, false to disable.
      '';
    };
  };

  config = {};
}
