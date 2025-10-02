#### NOTES
#### Horrible horrible gtk2 requirement app. Feels like it's on life support on linux
#### Currently cannot get later versions running on this POS
#### ~/.ICAClient/All_Regions.ini <- do: MouseSendsControlV=false
####
{
  pkgs,
  pkgsStable,
  config,
  lib,
  ...
}: let
  extraCerts = [
    ./secure/citrix-certs/Entrust_Root_G2.pem
    ./secure/citrix-certs/Entrust_L1K.pem
    ./secure/citrix-certs/dod-pki-bundle.pem
    ./secure/citrix-certs/DoD_PKE_CA_chain.pem
  ];
in {
  options.my.modules.misc.citrix = {
    enable = lib.mkEnableOption "Enable citrix and certs + smartcard stuff";
  };
  config = lib.mkIf config.my.modules.misc.citrix.enable {
    services.pcscd.enable = true;
    environment.systemPackages = [
      pkgs.opensc
      pkgs.pcsc-tools
      pkgs.p11-kit
      (pkgsStable.citrix_workspace.override {inherit extraCerts;})
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
