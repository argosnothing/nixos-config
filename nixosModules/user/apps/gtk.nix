{pkgs, ...}: {
  # Let Stylix handle most GTK theming, but add proper icon theme
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    # Ensure we have fallback icon themes for compatibility
    gtk3.extraConfig = {
      gtk-icon-theme-name = "Adwaita";
      gtk-fallback-icon-theme = "hicolor";
    };
    gtk4.extraConfig = {
      gtk-icon-theme-name = "Adwaita";
      gtk-fallback-icon-theme = "hicolor";
    };
  };
  
  # Add necessary icon packages
  home.packages = with pkgs; [
    adwaita-icon-theme
    hicolor-icon-theme
    # Additional icon themes for better app compatibility
    papirus-icon-theme
    numix-icon-theme-circle
  ];
}
