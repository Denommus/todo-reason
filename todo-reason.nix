{ ocamlPackages }:
ocamlPackages.buildDunePackage {
  pname = "todo-reason";
  version = "0.1";

  src = ./.;

  duneVersion = "3";

  buildInputs = [
    ocamlPackages.reason-react
  ];

  nativeBuildInputs = [
    ocamlPackages.melange
    ocamlPackages.reason
  ];
}
