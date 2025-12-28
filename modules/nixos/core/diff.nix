{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.core.diff;
in
{
  options.features.core.diff = {
    enable = lib.mkEnableOption "Nushell-based system closure diff on activation";
  };

  config = lib.mkIf cfg.enable {
    system.activationScripts.diff = ''
      if [[ -e /run/current-system ]]; then
        ${pkgs.nushell}/bin/nu -c "
          let diff_closure = (${pkgs.nix}/bin/nix store diff-closures /run/current-system '$systemConfig')
          let table = (
            \$diff_closure
            | lines
            | where \$it =~ KiB
            | where \$it =~ →
            | parse -r '^(?<Package>\S+): (?<Old>[^,]+)(?:.*) → (?<New>[^,]+)(?:.*), (?<DiffBin>.*)$'
            | insert Diff { get DiffBin | ansi strip | into filesize }
            | sort-by -r Diff
            | reject DiffBin
          )
          if (\$table | get Diff | is-not-empty) {
            print \"\"
            \$table
            | append [[Package Old New Diff]; [\"\" \"\" \"\" \"\"]]
            | append [[Package Old New Diff]; [\"\" \"\" \"Total:\" (\$table | get Diff | math sum) ]]
            | print
            print \"\"
          }
        "
      fi
    '';
  };
}
