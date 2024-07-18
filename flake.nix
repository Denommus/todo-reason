{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    ocaml-overlay.url = "github:nix-ocaml/nix-overlays";
    ocaml-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, flake-utils, ocaml-overlay, nixpkgs }@inputs:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        ocaml-overlay.overlays.default
      ];
    };

    package = pkgs.ocamlPackages.buildDunePackage {
      duneVersion = "3";
      version = "0.1";
      pname = "todo-reason";

      buildInputs = [
        pkgs.ocamlPackages.reason-react
      ];

      nativeBuildInputs = [
        pkgs.ocamlPackages.melange
        pkgs.ocamlPackages.reason
      ];

      src = ./.;
    };
  in {
    packages.default = package;
    packages.todo-reason = package;
  });
}
