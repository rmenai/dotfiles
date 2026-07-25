{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };

  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers = {
    dockge = {
      image = "louislam/dockge:1";
      autoStart = true;
      ports = [ "100.93.27.75:5001:5001" ];

      volumes = [
        "/run/podman/podman.sock:/var/run/docker.sock"
        "/opt/dockge/data:/app/data"
        "/opt/stacks:/opt/stacks"
      ];

      environment = {
        DOCKGE_STACKS_DIR = "/opt/stacks";
      };
    };
  };
}
