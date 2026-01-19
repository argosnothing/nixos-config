{
  flake.modules.nixos.quantum = {
    pkgs,
    lib,
    config,
    ...
  }: let
    user = config.my.username;
    home = "/home/${user}";

    host = config.my.hostname;
    repo = "${home}/nixos-config";
    quantumRoot = "${repo}/.quantum";

    entries =
      (config.my.quantum.directories or [])
      ++ (config.my.quantum.files or []);

    entriesFile =
      pkgs.writeText "quantum-entries" (lib.concatStringsSep "\n" entries + "\n");

    runuser = "${pkgs.util-linux}/bin/runuser";
    mkdir = "${pkgs.coreutils}/bin/mkdir";
    rm = "${pkgs.coreutils}/bin/rm";
    cat = "${pkgs.coreutils}/bin/cat";
    mktemp = "${pkgs.coreutils}/bin/mktemp";
    sort = "${pkgs.coreutils}/bin/sort";
    comm = "${pkgs.coreutils}/bin/comm";
    awk = "${pkgs.gawk}/bin/awk";
    mount = "${pkgs.util-linux}/bin/mount";
    umount = "${pkgs.util-linux}/bin/umount";
    dirname = "${pkgs.coreutils}/bin/dirname";
    stat = "${pkgs.coreutils}/bin/stat";

    script = pkgs.writeShellScript "apply-quantum-bindmounts" ''
      set -euo pipefail

      HOME=${lib.escapeShellArg home}
      ROOT=${lib.escapeShellArg quantumRoot}
      LIST=${lib.escapeShellArg entriesFile}
      STATE="$ROOT/.quantum.state.${lib.escapeShellArg host}"

      [ -d "$ROOT" ] || exit 0
      ${mkdir} -p -- "$ROOT"

      cur="$(${mktemp})"
      prev="$(${mktemp})"
      drop="$(${mktemp})"

      ${awk} '
        { gsub(/^[ \t]+|[ \t]+$/, "", $0) }
        $0 == "" { next }
        $0 ~ /^#/ { next }
        { print }
      ' "$LIST" | ${sort} -u > "$cur"

      if [ -f "$STATE" ]; then
        ${cat} -- "$STATE" | ${sort} -u > "$prev"
      else
        : > "$prev"
      fi

      ${comm} -23 "$prev" "$cur" > "$drop"

      while IFS= read -r rel; do
        [ -z "$rel" ] && continue
        target="$HOME/$rel"
        if ${mount}point -q -- "$target" 2>/dev/null; then
          ${umount} -- "$target" || true
        fi
      done < "$drop"

      while IFS= read -r rel; do
        [ -z "$rel" ] && continue

        src="$ROOT/$rel"
        target="$HOME/$rel"

        if [ -d "$src" ]; then
          ${mkdir} -p -- "$target"
        elif [ -f "$src" ]; then
          ${mkdir} -p -- "$(${dirname} -- "$target")"
          [ -e "$target" ] || : > "$target"
        else
          continue
        fi

        if ${mount}point -q -- "$target" 2>/dev/null; then
          continue
        fi

        ${mount} --bind -- "$src" "$target"
      done < "$cur"

      ${cat} -- "$cur" > "$STATE"
      ${rm} -f -- "$cur" "$prev" "$drop"
    '';
  in {
    config = {
      system.activationScripts.quantum = {
        supportsDryActivation = true;
        text = ''
          ${runuser} -u ${lib.escapeShellArg user} -- \
            env HOME=${lib.escapeShellArg home} \
            ${lib.escapeShellArg script}
        '';
      };
    };
  };
}
