## TODO, THIS stuff should really just be at a more top level. get on it?
{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.wms.mango.enable {
    home.packages = with pkgs; [
      wl-clipboard
      wl-copy
      slurp
      wf-recorder
      (pkgs.writeShellScriptBin
        "snip"
        ''
          ${pkgs.grim}/bin/grim -l 0 -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy
        '')
    ];
  };
}
