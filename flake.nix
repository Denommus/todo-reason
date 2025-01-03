{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    ocaml-overlay.url = "github:nix-ocaml/nix-overlays";
    ocaml-overlay.inputs.nixpkgs.follows = "nixpkgs";
    ocaml-overlay.inputs.flake-utils.follows = "flake-utils";
  };
  outputs =
    {
      flake-utils,
      ocaml-overlay,
      nixpkgs,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            ocaml-overlay.overlays.default
          ];
        };

        package = pkgs.ocamlPackages.callPackage ./todo-reason.nix { };
      in
      {
        packages.default = package;
        packages.todo-reason = package;

        devShells.default = pkgs.mkShell {
          inputsFrom = [
            package
          ];

          buildInputs = [
            pkgs.ocamlPackages.ocaml-lsp
            pkgs.ocamlPackages.utop
            pkgs.ocamlPackages.ocamlformat
            pkgs.nodejs
          ];
        };
      }
    );
}
