{ config, ... }:
let
  styles = config.lib.stylix.colors.withHashtag;
  font = config.stylix.fonts.monospace.name or "monospace";
in
''
''
