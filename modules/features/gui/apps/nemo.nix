{
  flake.modules.nixos.nemo = {
    hm = {pkgs, ...}: {
      home.packages = with pkgs; [nemo];
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "inode/directory" = ["nemo.desktop"];
          "application/x-gnome-saved-search" = ["nemo.desktop"];
        };
      };
    };
  };
}
