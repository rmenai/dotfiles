{
  inputs,
  hostSpec,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persist/home/${hostSpec.username}" = {
    allowOther = true;
  };
}
