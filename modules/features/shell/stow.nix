{
  flake.modules.nixos.stow = { pkgs, lib, config, ... }:
    let
      user = config.my.username;

      home = "/home/${user}";
      repo = "${home}/nix-config";
      stowRoot = "${repo}/.stow";
      whitelistFile = "${stowRoot}/whitelist";
      generatedPkg = "${stowRoot}/.whitelist";

      runuser = "${pkgs.util-linux}/bin/runuser";
      stow = "${pkgs.stow}/bin/stow";
      find = "${pkgs.findutils}/bin/find";
      sed = "${pkgs.gnused}/bin/sed";
      ln = "${pkgs.coreutils}/bin/ln";
      mkdir = "${pkgs.coreutils}/bin/mkdir";
      rm = "${pkgs.coreutils}/bin/rm";
      dirname = "${pkgs.coreutils}/bin/dirname";

      stowWhitelistScript = pkgs.writeShellScript "stow-whitelist" ''
        set -euo pipefail

        STOW_ROOT=${lib.escapeShellArg stowRoot}
        WHITELIST=${lib.escapeShellArg whitelistFile}
        PKG=${lib.escapeShellArg generatedPkg}
        TARGET=${lib.escapeShellArg home}

        if [ ! -d "$STOW_ROOT" ]; then
          echo "stow: missing $STOW_ROOT (skipping)" >&2
          exit 0
        fi

        if [ ! -f "$WHITELIST" ]; then
          echo "stow: missing $WHITELIST (skipping)" >&2
          exit 0
        fi

        ${rm} -rf -- "$PKG"
        ${mkdir} -p -- "$PKG"

        while IFS= read -r line; do
          line="$(${sed} -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' <<<"$line")"
          [ -z "$line" ] && continue
          case "$line" in \#*) continue ;; esac

          src="$STOW_ROOT/$line"

          if [ -d "$src" ]; then
            prefix="$STOW_ROOT/"
            while IFS= read -r -d '' f; do
              rel="''${f#"$prefix"}"
              ${mkdir} -p -- "$PKG/$(${dirname} -- "$rel")"
              ${ln} -sfn -- "$f" "$PKG/$rel"
            done < <(${find} "$src" -type f -print0)

          elif [ -f "$src" ]; then
            ${mkdir} -p -- "$PKG/$(${dirname} -- "$line")"
            ${ln} -sfn -- "$src" "$PKG/$line"

          else
            echo "stow: whitelist entry not found: $line" >&2
          fi
        done < "$WHITELIST"

        cd "$STOW_ROOT"
        ${stow} --no-folding -R -d "$STOW_ROOT" -t "$TARGET" ".whitelist"
      '';
    in
    {
      config = {
        environment.systemPackages = [ pkgs.stow ];

        system.activationScripts.stowWhitelist = {
          supportsDryActivation = true;
          text = ''
            set -euo pipefail
            ${runuser} -u ${lib.escapeShellArg user} -- \
              env HOME=${lib.escapeShellArg home} \
              ${lib.escapeShellArg stowWhitelistScript}
          '';
        };
      };
    };
}
