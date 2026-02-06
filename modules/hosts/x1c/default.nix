toplevel: {
  flake.nixosModules.host-x1c =
  { pkgs, ... }:
  {
  imports = with toplevel.config.flake.nixosModules; [
    plasma
    helix
  ];
  };
}
