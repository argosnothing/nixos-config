{pkgs, ...}: {
  home.packages = [
    # Create a nautilus wrapper that always uses X11 backend
    (pkgs.symlinkJoin {
      name = "nautilus-x11";
      paths = [ pkgs.nautilus ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/nautilus \
          --set GDK_BACKEND x11
      '';
    })
  ];
}
