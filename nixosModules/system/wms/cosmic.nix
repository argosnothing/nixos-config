{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    wms.cosmic.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable COSMIC desktop environment.";
    };
  };
  config = lib.mkIf config.wms.cosmic.enable {
    # COSMIC binary cache for faster builds
    nix.settings = {
      substituters = [ "https://cosmic.cachix.org/" ];
      trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
    };

    # Import COSMIC NixOS module
    imports = [ inputs.nixos-cosmic.nixosModules.default ];

    # Enable COSMIC desktop manager and greeter
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    # Enable Flatpak for COSMIC Store
    services.flatpak.enable = true;

    # Optional: Enable clipboard manager support
    environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = "1";

    # Optional: Enable Observatory system monitoring
    systemd.packages = [ pkgs.observatory ];
    systemd.services.monitord.wantedBy = [ "multi-user.target" ];

    # Basic desktop portal support
    services.dbus.enable = true;
    programs.dconf.enable = true;

    # Essential packages for COSMIC
    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      hicolor-icon-theme
      glib
      gsettings-desktop-schemas
    ];
  };
}
