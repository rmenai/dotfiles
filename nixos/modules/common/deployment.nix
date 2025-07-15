{ lib, ... }: {
  options.deployment = lib.mkOption {
    type = lib.types.submodule {
      options = {
        allowLocalDeployment = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description =
            "Allow the configuration to be applied locally on the host running Colmena.";
        };

        buildOnTarget = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description =
            "Whether to build the system profiles on the target node itself.";
        };

        keys = lib.mkOption {
          type = lib.types.attrsOf (lib.types.submodule {
            options = {
              destDir = lib.mkOption {
                type = lib.types.path;
                default = "/run/keys";
                description = "Destination directory on the host.";
              };

              group = lib.mkOption {
                type = lib.types.str;
                default = "root";
                description = "The group that will own the file.";
              };

              keyCommand = lib.mkOption {
                type = lib.types.nullOr (lib.types.listOf lib.types.str);
                default = null;
                description =
                  "Command to run to generate the key. One of text, keyCommand and keyFile must be set.";
              };

              keyFile = lib.mkOption {
                type = lib.types.nullOr lib.types.path;
                default = null;
                description =
                  "Path of the local file to read the key from. One of text, keyCommand and keyFile must be set.";
              };

              name = lib.mkOption {
                type = lib.types.str;
                description = "File name of the key.";
              };

              permissions = lib.mkOption {
                type = lib.types.str;
                default = "0600";
                description = "Permissions to set for the file.";
              };

              text = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description =
                  "Content of the key. One of text, keyCommand and keyFile must be set.";
              };

              uploadAt = lib.mkOption {
                type = lib.types.enum [ "pre-activation" "post-activation" ];
                default = "pre-activation";
                description = "When to upload the keys.";
              };

              user = lib.mkOption {
                type = lib.types.str;
                default = "root";
                description = "The user that will own the file.";
              };
            };
          });
          default = { };
          description = "A set of secrets to be deployed to the node.";
        };

        privilegeEscalationCommand = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ "sudo" "-H" "--" ];
          description =
            "Command to use to elevate privileges when activating the new profiles on SSH hosts.";
        };

        replaceUnknownProfiles = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description =
            "Allow a configuration to be applied to a host running a profile we have no knowledge of.";
        };

        sshOptions = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Extra SSH options to pass to the SSH command.";
        };

        tags = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "A list of tags for the node.";
        };

        targetHost = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = "nixos";
          description = "The target SSH node for deployment.";
        };

        targetPort = lib.mkOption {
          type = lib.types.nullOr lib.types.ints.unsigned;
          default = null;
          description = "The target SSH port for deployment.";
        };

        targetUser = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = "root";
          description = "The user to use to log into the remote node.";
        };
      };
    };
    default = { };
    description = "Colmena deployment configuration";
  };
}
