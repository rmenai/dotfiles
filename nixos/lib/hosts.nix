{ lib }: {
  discoverHosts = hostsDir:
    lib.filter (name: name != "common")
    (lib.attrNames (builtins.readDir hostsDir));
}
