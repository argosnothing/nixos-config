{
  flake.modules.nixos.plex = {pkgs, ...}: let
    myPlex = pkgs.plex.overrideAttrs (_: rec {
      version = "1.25.2.5319-c43dc0277";
      src = pkgs.fetchurl {
        url = "https://downloads.plex.tv/plex-media-server-new/${version}/redhat/plexmediaserver-${version}.x86_64.rpm";
        sha256 = "sha256-/Mr7U3L/OPbjORzoFXMtWKn0yV22vi4S4uaranoXuPw=";
      };
    });
  in {
    my.persist.root.directories = ["/var/lib/plex"];
    services = {
      plex = {
        enable = true;
        dataDir = "/var/lib/plex";
        openFirewall = true;
        package = myPlex;
        user = "plex";
        group = "plex";
      };
    };
  };
}
