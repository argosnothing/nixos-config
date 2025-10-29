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
    background = {
      name = "current.jpg";
      source = pkgs.copyPathToStore "${self}/.media/wallpapers/current.jpg";
    };
    wtf = pkgs.copyPathToStore "${self}/.media/wallpapers/current.jpg";
    bg = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/argosnothing/nixos-config/refs/heads/main/.media/wallpapers/current.jpg";
      hash = "sha256-QnMmuiwZsIBK4lvBESVI8UFbXJgJy+mrWbXaGim8BBc=";
    };
    zero-bg = pkgs.fetchurl {
      url = "https://www.desktophut.com/files/kV1sBGwNvy-Wallpaperghgh2Prob4.mp4";
      hash = "sha256-VkOAkmFrK9L00+CeYR7BKyij/R1b/WhWuYf0nWjsIkM=";
    };
    sddm-theme = inputs.silent-sddm.packages.${pkgs.system}.default.override {
      #theme = "catppuccin-mocha";
      theme = "rei";
      extraBackgrounds = [bg];
      theme-overrides = {
        "LoginScreen" = {
          background = "${bg.name}";
        };
        "LockScreen" = {
          background = "${bg.name}";
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
