{
  flake.modules.nixos.uhk = {pkgs, ...}: {
    hardware.keyboard.uhk.enable = true;
    services.udev.extraRules = ''
      SUBSYSTEM=="input", ATTRS{name}=="Ultimate.*", ENV{LIBINPUT_IGNORE_DEVICE}="0"
    '';

    environment.systemPackages = with pkgs; [
      uhk-agent
      uhk-udev-rules
    ];
    my.persist.home.directories = [".config/uhk-agent"];
  };
}
