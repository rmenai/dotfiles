{ config, lib, pkgs, ... }: {
  options.features.apps.oxidise = {
    enable = lib.mkEnableOption "Rust-based Unix utilities (uutils)";

    systemDiff = {
      enable = lib.mkEnableOption "Nushell system diff script" // {
        default = true;
      };
    };
  };

  config = lib.mkIf config.features.apps.oxidise.enable {
    environment.systemPackages =
      [ (lib.hiPrio pkgs.uutils-coreutils-noprefix) ];

    system.activationScripts.diff =
      lib.mkIf config.features.apps.oxidise.systemDiff.enable ''
        if [[ -e /run/current-system ]]; then
          ${pkgs.nushell}/bin/nu -c "let diff_closure = (${pkgs.nix}/bin/nix store diff-closures /run/current-system '$systemConfig'); let table = (\$diff_closure | lines | where \$it =~ KiB | where \$it =~ → | parse -r '^(?<Package>\S+): (?<Old>[^,]+)(?:.*) → (?<New>[^,]+)(?:.*), (?<DiffBin>.*)$' | insert Diff { get DiffBin | ansi strip | into filesize } | sort-by -r Diff | reject DiffBin); if (\$table | get Diff | is-not-empty) { print \"\"; \$table | append [[Package Old New Diff]; [\"\" \"\" \"\" \"\"]] | append [[Package Old New Diff]; [\"\" \"\" \"Total:\" (\$table | get Diff | math sum) ]] | print; print \"\" }"
        fi
      '';
  };
}
