{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.wms.niri.enable {
    home.packages = with pkgs; [
      wireplumber
      bibata-cursors
      qogir-theme # Includes cursor theme
      nwg-displays
      grim
      libsoup_3
      qogir-icon-theme
      alsa-utils
      fontconfig
      freetype
      xwayland
      xwayland-satellite

      # GUI-based programs
      nemo
      nemo-fileroller # Archive integration for nemo
      gnome-text-editor # Default text editor
      loupe # Image viewer

      # File operations and preview dependencies for yazi
      ffmpegthumbnailer # Video thumbnails
      unar # Archive extraction
      poppler_utils # PDF previews
      fd # Fast file finder
      ripgrep # Fast text search
      imagemagick # Image operations
    ];
  };
}
