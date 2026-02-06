{ lib, ... }:
{
  flake.nixosModules.core = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
