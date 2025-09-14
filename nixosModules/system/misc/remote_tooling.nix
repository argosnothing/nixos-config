{
  pkgs,
  pkgsStable,
  ...
}: let
  extraCerts = [
    ./secure/citrix-certs/Entrust_Root_G2.pem
    ./secure/citrix-certs/Entrust_L1K.pem
    ./secure/citrix-certs/dod-pki-bundle.pem
    ./secure/citrix-certs/DoD_PKE_CA_chain.pem
  ];
in {
  services.pcscd.enable = true;
  environment.systemPackages = [
    pkgs.opensc
    pkgs.pcsc-tools
    pkgs.p11-kit
    (pkgsStable.citrix_workspace.override {inherit extraCerts;})
  ];

  custom.persist.home = {
    directories = [
      ".ICAClient"
      ".config/Citrix"
      ".local/share/Citrix"
    ];
    files = [".local/share/applications/wfica.desktop"];
  };
}
