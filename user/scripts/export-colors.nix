{ config, pkgs, ... }:
let
  c  = config.lib.stylix.colors;
  ch = c.withHashtag;

  json = builtins.toJSON {
    base = {
      base00 = ch.base00; base01 = ch.base01; base02 = ch.base02; base03 = ch.base03;
      base04 = ch.base04; base05 = ch.base05; base06 = ch.base06; base07 = ch.base07;
      base08 = ch.base08; base09 = ch.base09; base0A = ch.base0A; base0B = ch.base0B;
      base0C = ch.base0C; base0D = ch.base0D; base0E = ch.base0E; base0F = ch.base0F;
    };
  };

  yaml = ''
    scheme: "Stylix Export"
    author: "Stylix"
    base00: "${c.base00}"
    base01: "${c.base01}"
    base02: "${c.base02}"
    base03: "${c.base03}"
    base04: "${c.base04}"
    base05: "${c.base05}"
    base06: "${c.base06}"
    base07: "${c.base07}"
    base08: "${c.base08}"
    base09: "${c.base09}"
    base0A: "${c.base0A}"
    base0B: "${c.base0B}"
    base0C: "${c.base0C}"
    base0D: "${c.base0D}"
    base0E: "${c.base0E}"
    base0F: "${c.base0F}"
  '';
in
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "stylix-export";
      text = ''
        set -euo pipefail
        mode="''${1:-json}"

        line() {
          n="$1"; h="''${2#\#}"
          r=$((16#''${h:0:2})); g=$((16#''${h:2:2})); b=$((16#''${h:4:2}))
          printf "%-6s #%s  \033[48;2;%d;%d;%dm   \033[0m\n" "$n" "$h" "$r" "$g" "$b"
        }

        case "$mode" in
          json) printf '%s\n' '${json}' ;;
          env)
            cat <<EOF
STYLIX_BASE00=${ch.base00}
STYLIX_BASE01=${ch.base01}
STYLIX_BASE02=${ch.base02}
STYLIX_BASE03=${ch.base03}
STYLIX_BASE04=${ch.base04}
STYLIX_BASE05=${ch.base05}
STYLIX_BASE06=${ch.base06}
STYLIX_BASE07=${ch.base07}
STYLIX_BASE08=${ch.base08}
STYLIX_BASE09=${ch.base09}
STYLIX_BASE0A=${ch.base0A}
STYLIX_BASE0B=${ch.base0B}
STYLIX_BASE0C=${ch.base0C}
STYLIX_BASE0D=${ch.base0D}
STYLIX_BASE0E=${ch.base0E}
STYLIX_BASE0F=${ch.base0F}
EOF
            ;;
          yaml) printf '%s\n' '${yaml}' ;;
          swatch)
            printf "%-6s %-7s %s\n" "index" "hex" "color"
            line base00 "${c.base00}"
            line base01 "${c.base01}"
            line base02 "${c.base02}"
            line base03 "${c.base03}"
            line base04 "${c.base04}"
            line base05 "${c.base05}"
            line base06 "${c.base06}"
            line base07 "${c.base07}"
            line base08 "${c.base08}"
            line base09 "${c.base09}"
            line base0A "${c.base0A}"
            line base0B "${c.base0B}"
            line base0C "${c.base0C}"
            line base0D "${c.base0D}"
            line base0E "${c.base0E}"
            line base0F "${c.base0F}"
            ;;
          *) echo "usage: stylix-export [json|env|yaml|swatch]" >&2; exit 2 ;;
        esac
      '';
    })
  ];
}
