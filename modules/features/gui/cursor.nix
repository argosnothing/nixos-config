{
  # This is for manually defining cursor stuff. I should not need to include this on most desktop environments
  # Mainly used to lighter stuff like xfce and window managers without batteries included.
  # This both makes options available and enables them. I don't anticipate other modules to draw on these options
  # outside of hosts that want to configure the options.
  flake.modules.nixos.cursor = {
    lib,
    pkgs,
    config,
    ...
  }: let
    inherit (lib) types mkOption mkEnableOption;
    inherit (types) package str int;
  in {
    options.my.cursor = {
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
    config = {
      my.cursor = {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
      };
      environment.sessionVariables = {
        XCURSOR_THEME = config.my.cursor.name;
        XCURSOR_SIZE = config.my.cursor.size;
      };
      hm = {pkgs, ...}: {
        home.packages = [pkgs.dconf];
        home.pointerCursor = {
          enable = true;
          gtk.enable = true;
          x11.enable = true;
          inherit (config.my.cursor) name;
          inherit (config.my.cursor) package;
          inherit (config.my.cursor) size;
        };
      };
    };
  };
}
