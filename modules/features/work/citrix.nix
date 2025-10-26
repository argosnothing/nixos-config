{inputs, ...}: let
  inherit (inputs) nixpkgs-stable;
in {
  flake.modules.nixos.work = {pkgs, ...}: let
    pkgs-stable = import nixpkgs-stable {
      inherit (pkgs) system;
      config = {
        allowUnfree = true;
        allowAliases = true;
        permittedInsecurePackages = ["libsoup-2.74.3" "libxml2-2.13.8"];
      };
    };
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
      (pkgs-stable.citrix_workspace.override {inherit extraCerts;})
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
