{
  perSystem = {
    packages.ns = {
      lib,
      appimageTools,
      fetchurl,
    }: let
      pname = "fluxer";
      version = "stable";

      src = fetchurl {
        name = "Fluxer.AppImage";
        url = "https://api.fluxer.app/dl/desktop/stable/linux/x64/latest/appimage";
        hash = "sha256-GdoBK+Z/d2quEIY8INM4IQy5tzzIBBM+3CgJXQn0qAw=";
      };
    in
      appimageTools.wrapType2 {
        inherit pname version src;

        extraInstallCommands = ''
          mkdir -p $out/share/applications
          cat > $out/share/applications/fluxer.desktop <<'EOF'
          [Desktop Entry]
          Name=Fluxer
          Exec=fluxer
          Type=Application
          Categories=Network;
          Terminal=false
          EOF
        '';

        meta = with lib; {
          description = "Fluxer desktop client";
          homepage = "https://fluxer.app/";
          license = licenses.agpl3Only;
          platforms = ["x86_64-linux"];
          mainProgram = "fluxer";
        };
      };
  };
}
