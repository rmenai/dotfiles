{ config, lib, ... }:
{
  config = {
    time.timeZone = lib.mkDefault config.spec.timeZone;
    i18n.defaultLocale = lib.mkDefault config.spec.defaultLocale;
  };
}
