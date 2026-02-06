{ config, inputs, self, ...}:
let 
  inherit (inputs.nixpkgs) lib;
  user = "elias-ainsworth";
  mkNixos =
    host:
    {}:
    lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          self
          host
          user
          ;
        isLaptop = host == "x1c";
        dots = "/home/${user}/projects/thorneos";
      };

      modules = [
        config.flake.nixosModules."host-${host}"
        config.flake.nixosModules.core
      ];
    };
in
{
  flake.nixosConfigurations = {
    x1c = mkNixos "x1c" { };
  };
}
