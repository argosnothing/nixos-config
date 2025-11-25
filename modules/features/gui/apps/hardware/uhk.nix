{
  flake.modules.nixos.uhk = {pkgs, ...}: {
    hardware.keyboard.uhk.enable = true;
    environment.systemPackages = with pkgs; [
      uhk-agent
      uhk-udev-rules
    ];
    my.persist.home.directories = [".config/uhk-agent"];
  };
}
