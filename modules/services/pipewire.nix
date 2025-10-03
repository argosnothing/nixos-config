{
  config,
  lib,
  ...
}: {
  options = {
    my.modules.services.pipewire.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable PipeWire audio configuration.";
    };
  };

  config = lib.mkIf config.my.modules.services.pipewire.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
