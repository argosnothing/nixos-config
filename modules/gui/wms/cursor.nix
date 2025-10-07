# https://github.com/iynaix/dotfiles/blob/89752c09b99b1e86fceafcc3183500dbbb4019bc/modules/gui/gtk.nix#L74
# Mainly just for the options, was too lazy to just do it myself lol
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkOption mkDefault;
  inherit (lib.types) package str int;
in {
  _hm = _: {
    options.my.modules.gui.wms.cursor = {
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
    config = mkIf config.my.modules.gui.wms.cursor.enable {
      hm = _: {
        home.pointerCursor = {
          enable = true;
          gtk.enable = true;
          x11.enable = true;
          inherit (config.my.modules.gui.wms.cursor) name;
          inherit (config.my.modules.gui.wms.cursor) package;
          inherit (config.my.modules.gui.wms.cursor) size;
        };
      };
    };
  };
}
