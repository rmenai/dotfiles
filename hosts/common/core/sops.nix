{
  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };

  environment.persistence."/persist/system" = {
    directories = [
      "/var/lib/sops-nix"
    ];
  };

  fileSystems."/var/lib/sops-nix".neededForBoot = true;
  fileSystems."/etc/ssh".neededForBoot = true;
}
