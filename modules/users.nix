{ lib, ... }:
{
  flake.nixosModules.core = {
    users.users.elias-ainsworth = {
      isNormalUser = true;
      description = "Elias Ainsworth";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
