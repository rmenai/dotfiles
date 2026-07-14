{ config, ... }: {
  # programs.ssh.extraConfig = ''
  #   UpdateHostKeys ask
  #   AddKeysToAgent yes
  #
  #   Host kali
  #     HostName kali
  #     User rami
  #     IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519_vm
  #     ForwardAgent yes
  #     ForwardX11 yes
  #     ForwardX11Trusted yes
  #
  #   Host flare
  #     HostName flare
  #     User rami
  #     IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519_vm
  #     ForwardAgent yes
  #
  #   Host vm
  #     HostName vm
  #     User rami
  #     IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519_vm
  #     ForwardAgent yes
  #     ForwardX11 yes
  #     ForwardX11Trusted yes
  #
  #   Host kernel
  #     HostName kernel
  #     User rami
  #     IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519
  #     ForwardAgent yes
  #     ForwardX11 yes
  #     ForwardX11Trusted yes
  # '';
}
