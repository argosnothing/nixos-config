{
  flake.modules.nixos.keyd = {
    lib,
    config,
    ...
  }: let
    inherit (lib) types mkOption mkEnableOption;
    inherit (types) bool;
    keyd = config.my.hardware.keyd;
  in {
    options = {
      my.hardware.keyd = {
        hhkb-override = mkEnableOption "Apply Override to emulate hhkb key placement";
      };
    };
    config = {
      services.keyd = {
        enable = true;
        keyboards.default = {
          ids = ["*"];
          settings = {
            main = lib.mkIf keyd.hhkb-override {
              capslock = "overload(control, esc)";
              backslash = "backspace";
              backspace = "backslash";
            };
            "shift" = {
              esc = "~";
            };
          };
        };
      };

      environment.etc."libinput/local-overrides.quirks".text = ''
        [Serial Keyboards]
        MatchUdevType=keyboard
        MatchName=keyd*keyboard
        AttrKeyboardIntegration=internal
      '';
    };
  };
}
