{ config, lib, pkgs, ... }: {
  options.features.dotfiles = {
    enable = lib.mkEnableOption "dotfiles management";
    paths = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description =
        "Mapping of destination file paths to source subdirectories inside ~/.dotfiles.";
    };

    autoSetupLocal = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Create ~/.dotfiles from flake input if it doesn't exist";
    };
  };

  config = lib.mkIf config.features.dotfiles.enable
    (let localFolder = "/home/${config.home.username}/.dotfiles";
    in {
      # Create editable dotfiles directory from flake input if it doesn't exist
      home.activation = lib.mkIf config.features.dotfiles.autoSetupLocal {
        setupDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          if [ ! -d "${localFolder}" ]; then
            run mkdir -p "$(dirname "${localFolder}")"

            # Simple retry for the git clone
            for attempt in {1..3}; do
              if run ${pkgs.git}/bin/git clone https://github.com/rmenai/dotfiles.git "${localFolder}"; then
                run cd "${localFolder}"
                run ${pkgs.git}/bin/git submodule update --init --recursive
                run chmod -R u+w "${localFolder}" || true
                echo "Cloned dotfiles repository with submodules at ${localFolder}"
                break
              else
                echo "Git clone attempt $attempt failed, retrying..."
                sleep 2
              fi
            done
          fi
        '';
      };

      home.file = builtins.mapAttrs (target: file: {
        source = config.lib.file.mkOutOfStoreSymlink "${localFolder}/${file}";
      }) (lib.filterAttrs (k: v: v != "") config.features.dotfiles.paths);
    });
}
