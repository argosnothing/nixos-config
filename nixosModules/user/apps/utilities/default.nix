{
  pkgs,
  settings,
  config,
  ...
}: {
  imports = [
    ./zoxide
  ];
  custom.persist.home.directories = [
    ".local/share/zoxide"
  ];
}
