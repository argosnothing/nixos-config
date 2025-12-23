{config, ...}: let
  inherit (config.flake.lib) mk-pkgs-stable;
in {
  flake.modules.nixos.work = {pkgs, ...}: let
    pkgs =
      import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/29b6e7097f50955f49a81d2665fb21c94c43df19.tar.gz";
        sha256 = "0zrkfxj130gbgixgk8yaxk5d9s5ppj667x38n4vys4zxw5r60bjz";
      }) {
        config = {
          allowUnfree = true;
          allowInsecure = true;
          permittedInsecurePackages = [
            "libsoup-2.74.3"
          ];
        };
      };
    citrix_workspace_overlay = pkgs.citrix_workspace;
    pkgs-stable = mk-pkgs-stable pkgs;
    extraCerts = [
      ./secure/citrix-certs/Entrust_Root_G2.pem
      ./secure/citrix-certs/Entrust_L1K.pem
      ./secure/citrix-certs/dod-pki-bundle.pem
      ./secure/citrix-certs/DoD_PKE_CA_chain.pem
      ./secure/citrix-certs/Iden.pem
    ];
  in {
    security.pki.certificateFiles = extraCerts;
    services.pcscd.enable = true;
    environment.systemPackages = [
      pkgs.opensc
      pkgs.pcsc-tools
      pkgs.p11-kit
      (citrix_workspace_overlay.override {inherit extraCerts;})
    ];

    my.persist.home = {
      directories = [
        ".ICAClient"
        ".config/Citrix"
        ".local/share/Citrix"
        ".pki"
      ];
      files = [".local/share/applications/wfica.desktop"];
    };
  };
}
