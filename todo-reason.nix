{
  buildDunePackage,
  reason-react,
  reason-react-ppx,
  melange,
  reason,
}:
buildDunePackage {
  pname = "todo-reason";
  version = "0.1";

  src = ./.;

  duneVersion = "3";

  buildInputs = [
    reason-react
    reason-react-ppx
  ];

  nativeBuildInputs = [
    melange
    reason
  ];
}
