{
  config,
  inputs,
  self,
  globals,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
  mkNixos =
    host:
    {
      isVm ? false,
      extraConfig ? { },
    }:
    lib.nixosSystem {
      specialArgs = rec {
        inherit
          inputs
          self
          host
          isVm
          globals
          ;
        user = globals.user;
        isNixOS = true;
        isLaptop = host == "sv9";
        dots = "/home/${user}/projects/dotfiles";
      };

      modules = [
        config.flake.nixosModules."host-${host}"
        config.flake.nixosModules.core
        inputs.hjem.nixosModules.default
        inputs.noctalia.nixosModules.default
        # alias for hjem
        (lib.mkAliasOptionModule [ "hj" ] [ "hjem" "users" globals.user ])
        extraConfig
      ];
    };
  mkVm = host: mkNixosArgs: mkNixos host (mkNixosArgs // { isVm = true; });
in
{
  flake.nixosConfigurations = {
    sv9 = mkNixos "sv9" { };
  };
}
