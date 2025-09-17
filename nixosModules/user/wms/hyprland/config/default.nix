{pkgs, ...}: {
  imports = [
    ./cursor.nix
    ./nav-bindings.nix
    ./packages.nix
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config = {
      common = {
        "org.freedesktop.portal.FileChooser" = ["gtk"];
      };
    };
  };
}
