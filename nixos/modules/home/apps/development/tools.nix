{ config, lib, ... }:
{
  options.features.apps.development.tools = {
    enable = lib.mkEnableOption "Neofetch system information tool";
  };

  config = lib.mkIf config.features.apps.development.tools.enable {
    features.apps.tools = {
      core.enable = true;
      bat.enable = true;
      eza.enable = true;
      fzf.enable = true;
      neofetch.enable = true;
      yazi.enable = true;
      zoxide.enable = true;
      neovim.enable = true;
    };
  };
}
