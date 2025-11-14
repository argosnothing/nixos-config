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
        (pkgs.writeShellScriptBin "record-region-gif" ''
          TMP_GIF="$(mktemp --suffix=.gif)"
          TMP_PALETTE="$(mktemp --suffix=.png)"

          record-region

          MP4_FILE="$(wl-paste --type text/uri-list | sed 's|file://||')"

          ${pkgs.ffmpeg}/bin/ffmpeg -i "$MP4_FILE" \
            -vf "fps=15,scale=800:-1:flags=lanczos,palettegen=stats_mode=full" \
            -y "$TMP_PALETTE"

          ${pkgs.ffmpeg}/bin/ffmpeg -i "$MP4_FILE" -i "$TMP_PALETTE" \
            -lavfi "fps=15,scale=800:-1:flags=lanczos[x];[x][1:v]paletteuse=dither=none" \
            -loop 0 -y "$TMP_GIF"

          rm -f "$TMP_PALETTE"

          printf 'file://%s\n' "$TMP_GIF" | wl-copy --type text/uri-list
        '')
      ];
    };
  };
}
