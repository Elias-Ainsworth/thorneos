{ globals, ... }:
{
  flake.nixosModules.core = {
    users.users.${globals.user} = {
      isNormalUser = true;
      description = globals.name;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
