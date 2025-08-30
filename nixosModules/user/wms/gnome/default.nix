{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    wms.gnome.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable GNOME desktop environment.";
    };
  };
  config = lib.mkIf config.wms.gnome.enable {
    home.packages = with pkgs; [
    ];
    styles.stylix.enable = false;
    # Enable GNOME fractional scaling (allows 150% in display settings)
    dconf.settings = {
      "org/gnome/mutter" = {
        "experimental-features" = ["scale-monitor-framebuffer"];
        # Note: 1.5 is not always respected, but this enables 150% in the GUI
        # "preferred-scaling-factor" = 1.5; # Uncomment if you want to try forcing 150%
      };
    };
  };
}
