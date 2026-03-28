{inputs, ...}: {
  flake.modules.nixos.dank-material-shell = {
    pkgs,
    config,
    ...
  }: {
    programs.dms-shell = {
      enable = true;
      quickshell.package = inputs.quickshell.packages.${pkgs.system}.quickshell;
    };
  };
}
