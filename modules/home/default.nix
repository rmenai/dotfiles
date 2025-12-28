{ lib, inputs, ... }@args:
{
  imports =
    (lib.optionals (!(args ? osConfig)) [ inputs.niri.homeModules.niri ])

    ++ [
      inputs.sops-nix.homeManagerModules.sops
      inputs.catppuccin.homeModules.catppuccin

      "${inputs.secrets}/home.nix"
    ]

    # Auto-import modules from specific subdirectories
    ++ (lib.concatMap
      (
        dir:
        lib.pipe dir [
          lib.filesystem.listFilesRecursive
          (map toString)
          (lib.filter (
            # Ignore any path with /_
            path: lib.strings.hasSuffix ".nix" (toString path) && !(lib.strings.hasInfix "/_" (toString path))
          ))
        ]
      )
      [
        ./apps
        ./core
        ./desktop
        ./profiles
        ./services
      ]
    );
}
