{
  config,
  inputs,
  self,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos.sddm = {
    pkgs,
    lib,
    config,
    ...
  }: let
    background = pkgs.copyPathToStore (self + "/.media/wallpapers/current.jpg");
    sddm-theme = inputs.silent-sddm.packages.${pkgs.system}.default.override {
      theme = "catppuccin-mocha";
      theme-overrides = {
        "LoginScreen" = {
          background = "${background.name}";
        };
      };
    };
  in {
    imports = [flake.modules.nixos.display-manager];
    qt.enable = true;
    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
          wayland.compositorCommand = "${lib.getExe' pkgs.kdePackages.kwin "kwin_wayland"} --drm --no-lockscreen --no-global-shortcuts --locale1";
          package = pkgs.kdePackages.sddm;
          theme = sddm-theme.pname;
          extraBackground = [background];
          extraPackages =
            [
              pkgs.kdePackages.layer-shell-qt
            ]
            ++ sddm-theme.propagatedBuildInputs;
          settings = {
            General = {
              GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard,QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
              InputMethod = "qtvirtualkeyboard";
            };
            Theme = {
              CursorTheme = config.my.cursor.name;
              CursorSize = config.my.cursor.size;
            };
          };
        };
      };
    };
    environment.systemPackages = [sddm-theme sddm-theme.test];
    my.persist = {
      root = {
        cache.directories = ["/var/lib/sddm/.cache"];
        directories = ["/var/lib/sddm"];
      };
      home = {
        directories = [
          ".local/share/sddm"
        ];
        cache.directories = [".cache/sddm-greeter-qt6"];
      };
    };
  };
}
