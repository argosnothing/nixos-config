{inputs, ...}: {
  flake.modules.nixos.spicetify = {
    pkgs,
    config,
    lib,
    ...
  }: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    themeName = config.my.theme.name;
    themeConfig = {
      "rose-pine" = {
        theme = spicePkgs.themes.ziro;
        colorScheme = "rose-pine-moon";
      };
      "rose-pine-dawn" = {
        theme = spicePkgs.themes.ziro;
        colorScheme = "rose-pine-dawn";
      };
      "catppuccin" = {
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
      };
      "catppuccin-latte" = {
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "latte";
      };
    };
    selectedTheme = themeConfig.${themeName} or themeConfig."catppuccin";
  in {
    imports = [inputs.spicetify-nix.nixosModules.default];
    environment.systemPackages = with pkgs; [spicetify-cli];
    my.persist.home.directories = [".config/spotify"];
    programs.spicetify = {
      enable = true;
      #theme = selectedTheme.theme;
      #colorScheme = selectedTheme.colorScheme;
    };
  };
}
