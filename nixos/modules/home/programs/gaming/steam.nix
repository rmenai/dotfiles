{lib, ...}: {
  features.persist = {
    directories = {
      ".steam" = lib.mkDefault true;
    };
  };
}
