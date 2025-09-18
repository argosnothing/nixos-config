{
  pkgs,
  settings,
  config,
  ...
}: {
  imports = [
    ./zoxide
  ];
  custom.persist.directories = [
    ".local/share/zoxide"
  ];
}
