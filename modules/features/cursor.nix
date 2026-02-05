{
  # This is for manually defining cursor stuff. I should not need to include this on most desktop environments
  # Mainly used for lighter stuff like xfce and window managers without batteries included.
  # This both makes options available and enables them. I don't anticipate other modules to draw on these options
  # outside of hosts that want to configure the options.
  flake.modules.nixos.cursor = {
    lib,
    pkgs,
    config,
    ...
  }: let
    inherit (lib) types mkOption mkEnableOption mkIf gvariant;
    inherit (gvariant) mkInt32;
    inherit (types) package str int float;
  in {
    options.my.cursor = {
      speed = mkOption {
        description = "The cursor speed offset from base as 1 = base";
        default = 1.0;
        type = float;
      };
      enable = mkEnableOption "Enable Explicit Cursor Management";
      package = mkOption {
        type = package;
        default = pkgs.simp1e-cursors;
        description = "Package providing the cursor theme.";
      };
      name = mkOption {
        type = str;
        default = "Simp1e-Tokyo-Night";
        description = "The cursor name within the package.";
      };
      size = mkOption {
        type = int;
        default = 28;
        description = "The cursor size.";
      };
    };
    config = mkIf config.my.cursor.enable {
      environment.systemPackages = [config.my.cursor.package];
      environment.variables = {
        XCURSOR_THEME = config.my.cursor.name;
        XCURSOR_SIZE = toString config.my.cursor.size;
        XCURSOR_PATH = lib.mkForce "${config.my.cursor.package}/share/icons";
      };

      hj.files.".icons/default".source = "${config.my.cursor.package}/share/icons/${config.my.cursor.name}";
      hj.files.".Xresources".text = ''
        Xcursor.theme: ${config.my.cursor.name}
        Xcursor.size: ${toString config.my.cursor.size}
      '';

      programs.dconf.enable = true;

      programs.dconf.profiles.user.databases = [
        {
          settings = {
            "org/gnome/desktop/interface" = {
              cursor-theme = config.my.cursor.name;
              cursor-size = mkInt32 config.my.cursor.size;
            };
          };
        }
      ];
    };
  };
}
