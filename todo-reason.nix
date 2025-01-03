{
  buildDunePackage,
  reason-react,
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
  ];

  nativeBuildInputs = [
    melange
    reason
  ];
}
