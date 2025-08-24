{
  pkgs,
  inputs,
  settings,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
    ../../stylix-config.nix
  ];
  stylix.targets.hyprland.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${settings.stylixTheme}.yaml";
  stylix.targets.firefox = {
    enable = true;
    profileNames = ["default"];
  };
  stylix.targets.vscode.enable = true;
}
