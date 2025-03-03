{
  config,
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

  home.file = {
    ".histfile".source = config.lib.file.mkOutOfStoreSymlink "/persist${config.home.homeDirectory}/.histfile";
  };
}
