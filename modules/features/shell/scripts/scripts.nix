{
  flake.modules.nixos.misc-scripts = {
    hm = {pkgs, ...}: {
      home.packages = with pkgs; [
        wl-clipboard
        slurp
        wf-recorder
        (pkgs.writeShellScriptBin
          "snip"
          ''
            ${pkgs.grim}/bin/grim -l 0 -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy
          '')
        (pkgs.writeShellScriptBin "record-region" ''
          FILE="$(mktemp --suffix=.mp4)"
          SRC="$(${pkgs.pulseaudio}/bin/pactl get-default-sink).monitor"
          ${pkgs.wf-recorder}/bin/wf-recorder \
            -g "$(${pkgs.slurp}/bin/slurp)" \
            --audio="$SRC" \
            --audio-backend=pipewire \
            -C aac \
            -f "$FILE" -y
          printf 'file://%s\n' "$FILE" | wl-copy --type text/uri-list
        '')
      ];
    };
  };
}
