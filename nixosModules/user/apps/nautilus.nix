{pkgs, ...}: {
  home.packages = with pkgs; [
    nautilus
  ];
  
  # Set X11 backend for nautilus to prevent crashes on close
  home.sessionVariables = {
    # Only affect nautilus specifically
  };
  
  # Alternative: use programs.nautilus when available, or desktop entry override
  xdg.desktopEntries.nautilus = {
    name = "Files";
    comment = "Access and organize files";
    exec = "env GDK_BACKEND=x11 nautilus %U";
    icon = "org.gnome.Nautilus";
    mimeType = ["inode/directory"];
    categories = ["Utility" "Core" "GTK"];
    startupNotify = true;
  };
}
