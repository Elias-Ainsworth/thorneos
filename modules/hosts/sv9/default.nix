toplevel: {
  flake.nixosModules.host-sv9 =
  { pkgs, ... }:
  {
  imports = with toplevel.config.flake.nixosModules; [
    plasma
    helix
  ];
  };
}
