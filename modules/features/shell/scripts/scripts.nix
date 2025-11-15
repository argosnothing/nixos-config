{inputs, ...}: let
  inherit (inputs) nixpkgs-stable;
in {
  flake.modules.nixos.misc-scripts = {pkgs, ...}: let
    pkgs-stable = import nixpkgs-stable {
      inherit (pkgs) system;
      config = {
        allowUnfree = true;
        allowAliases = true;
        permittedInsecurePackages = ["libsoup-2.74.3" "libxml2-2.13.8"];
      };
    };
  in {
    hm = {
      home.packages = with pkgs-stable; [
        pkgs.wl-clipboard
        slurp
        wf-recorder
        (pkgs.writeShellScriptBin
          "snip"
          ''
            ${pkgs-stable.grim}/bin/grim -l 0 -g "$(${pkgs-stable.slurp}/bin/slurp)" - | wl-copy
          '')
        (pkgs.writeShellScriptBin "record-region" ''
          FILE="$(mktemp --suffix=.mp4)"
          SRC="$(${pkgs.pulseaudio}/bin/pactl get-default-sink).monitor"
          ${pkgs-stable.wf-recorder}/bin/wf-recorder \
            -g "$(${pkgs-stable.slurp}/bin/slurp)" \
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

          ${pkgs-stable.ffmpeg}/bin/ffmpeg -i "$MP4_FILE" \
            -vf "fps=15,scale=800:-1:flags=lanczos,palettegen=stats_mode=full" \
            -y "$TMP_PALETTE"

          ${pkgs-stable.ffmpeg}/bin/ffmpeg -i "$MP4_FILE" -i "$TMP_PALETTE" \
            -lavfi "fps=15,scale=800:-1:flags=lanczos[x];[x][1:v]paletteuse=dither=none" \
            -loop 0 -y "$TMP_GIF"

          rm -f "$TMP_PALETTE"

          printf 'file://%s\n' "$TMP_GIF" | wl-copy --type text/uri-list
        '')
      ];
    };
  };
}
