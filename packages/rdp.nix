{
  perSystem = {pkgs, ...}: {
    packages.rdp = pkgs.symlinkJoin {
      name = "freerdp-smartcard";
      paths = [pkgs.freerdp];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/xfreerdp \
          --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath [
          pkgs.opensc
          pkgs.p11-kit
        ]}
      '';
    };
  };
}
