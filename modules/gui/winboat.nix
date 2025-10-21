{lib, inputs, config, ...}:let
  inherit (config.my.modules.gui) winboat;
  inherit (lib) mkIf mkEnableOption;
in{
  options.my.modules.gui.winboat = {
    enable = mkEnableOption "Enable Winboat";
  };
  config = mkIf winboat.enable {
    environment.systemPackages = [
      inputs.winboat.default
    ];
  };
}
