{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    wrappers = {
      url = "github:Lassulus/wrappers";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = 
    inputs @ { flake-parts, ...}:
  	let
      inherit (inputs.nixpkgs.lib.fileset) toList fileFilter;
      import-tree = 
        path:
        toList (fileFilter (file: file.hasExt "nix" && !(inputs.nixpkgs.lib.hasPrefix "_" file.name)) path);
    in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = import-tree ./modules;
    };
}
