{
  config,
  inputs,
  ...
}: {
  flake.modules.nixos.sddm = {pkgs, ...}: let
    silent-sddm = inputs.silent-sddm.packages.${pkgs.system}.default;
  in {
    imports = [config.flake.modules.nixos.display-manager];
    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
          theme = "catppuccin-mocha";
          settings = {
            General = {
              GreeterEnvironment = "QML2_IMPORT_PATH=${silent-sddm}/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard";
              InputMethod = "qtvirtualkeyboard";
            };
          };
          extraPackages = [silent-sddm];
        };
      };
    };
    environment.systemPackages = [inputs.silent-sddm.packages.${pkgs.system}.default];
  };
}
