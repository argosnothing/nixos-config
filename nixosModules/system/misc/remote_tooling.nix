{pkgs, ...}: let
  extraCerts = [
    ./secure/citrix-certs/Entrust_Root_G2.pem
    ./secure/citrix-certs/Entrust_L1K.pem
    ./secure/citrix-certs/dod-pki-bundle.pem
    ./secure/citrix-certs/DoD_PKE_CA_chain.pem
  ];
in {
  services.pcscd.enable = true;
  environment.systemPackages = with pkgs; [
    opensc
    pcsc-tools
    p11-kit
    (citrix_workspace.override {inherit extraCerts;})
  ];
}
