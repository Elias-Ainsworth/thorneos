{
  description = "A very basic flake";

  inputs = {
    # core
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    hjem = {
      url = "github:feel-co/hjem";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        smfh.inputs.systems.follows = "systems";
      };
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrappers = {
      url = "github:Lassulus/wrappers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    thornevim = {
      url = "github:elias-ainsworth/thornevim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    let
      inherit (inputs.nixpkgs.lib.fileset) toList fileFilter;
      import-tree =
        path:
        toList (fileFilter (file: file.hasExt "nix" && !(inputs.nixpkgs.lib.hasPrefix "_" file.name)) path);
      globals = {
        user = "elias-ainsworth";
        email = "pilum-murialis.toge@proton.me";
        name = "Elias-Ainsworth";
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = import-tree ./modules;
      _module.args.globals = globals;
    };
}
