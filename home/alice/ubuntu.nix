{ func, lib, ... }:
{
  imports = lib.flatten [
    (map func.custom.relativeToRoot [ "modules/common" ])
    (map func.custom.relativeToRoot [ "modules/home" ])
  ];

  spec = {
    user = "alice";
    handle = "rmenai";
    userFullName = "Rami Menai";
    email = "rami@menai.me";
  };

  features.profiles.core.enable = true;
}
