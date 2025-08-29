{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    wms.cosmic.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable COSMIC user configuration.";
    };
  };
  config = lib.mkIf config.wms.cosmic.enable {
    # COSMIC is a full desktop environment, most configuration
    # is done through the COSMIC settings app rather than Nix
    
    # Add any user-specific packages that complement COSMIC
    home.packages = with pkgs; [
      # File manager (if not using COSMIC Files)
      nautilus
      
      # Additional utilities that work well with COSMIC
      gnome-calculator
      gnome-calendar
      
      # Flatpak support for user
      flatpak
    ];

    # Set up Flatpak user repository
    home.activation.setupFlatpak = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if command -v flatpak >/dev/null 2>&1; then
        $DRY_RUN_CMD flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo || true
      fi
    '';

    # Basic XDG desktop integration
    xdg.enable = true;
    xdg.mimeApps.enable = true;
  };
}
