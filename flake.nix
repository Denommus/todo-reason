{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs =
    {
      flake-utils,
      nixpkgs,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
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
