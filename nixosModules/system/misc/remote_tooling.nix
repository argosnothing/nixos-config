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
  
  # Fix Citrix middle mouse click issue
  # Override the All_Regions.ini to disable MouseSendsControlV
  environment.etc."opt/citrix-icaclient/config/All_Regions.ini".text = ''
    ; Citrix ICA Client Configuration - Fixed for middle mouse click
    ; This file was modified to fix middle mouse click paste issue
    
    [Virtual Channels\Mouse]
    ClientMouseDoubleClickDetect=*
    MouseTimer=*
    MouseMap=
    MouseXButtonMapping=
    MouseWheelMapping=
    MouseScrollAmount=*
    MouseSendsControlV=False
    RelativeMouse=*
    RelativeMousePointerFeedback=*
    RelativemouseOnChar=
    RelativeMouseOnShift=
    RelativeMouseOffChar=
    RelativeMouseOffShift=
    SoftwareMouse=*
    ZLMouseMode=*
    
    ; Add other necessary sections from original file if needed
  '';
}
