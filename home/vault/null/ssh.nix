{ config, ... }: {
  programs.ssh.extraConfig = ''
    UpdateHostKeys ask
    AddKeysToAgent yes

    Host kali
      HostName kali
      User vault
      IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519_vm
      ForwardAgent yes
      ForwardX11 yes
      ForwardX11Trusted yes

    Host flare
      HostName flare
      User vault
      IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519_vm
      ForwardAgent yes

    Host vm
      HostName vm
      User vault
      IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519_vm
      ForwardAgent yes
      ForwardX11 yes
      ForwardX11Trusted yes

    Host kernel
      HostName kernel
      User vault
      IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519
      ForwardAgent yes
      ForwardX11 yes
      ForwardX11Trusted yes
  '';
}
