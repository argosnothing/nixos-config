{
  flake.modules.nixos.stow = {
    pkgs,
    lib,
    config,
    ...
  }: let
    user = config.my.username;
    home = "/home/${user}";

    repo = "${home}/nix-config";
    stowRoot = "${repo}/.stow";
    pkg = "${stowRoot}/.whitelist";

    runuser = "${pkgs.util-linux}/bin/runuser";
    stow = "${pkgs.stow}/bin/stow";
    find = "${pkgs.findutils}/bin/find";
    sed = "${pkgs.gnused}/bin/sed";
    ln = "${pkgs.coreutils}/bin/ln";
    mkdir = "${pkgs.coreutils}/bin/mkdir";
    rm = "${pkgs.coreutils}/bin/rm";
    dirname = "${pkgs.coreutils}/bin/dirname";

    entries =
      (config.my.stow.directories or [])
      ++ (config.my.stow.files or []);

    whitelistText =
      lib.concatStringsSep "\n" entries + "\n";

    whitelistFile = pkgs.writeText "stow-whitelist" whitelistText;

    script = pkgs.writeShellScript "stow-whitelist" ''
      set -euo pipefail

      STOW_ROOT=${lib.escapeShellArg stowRoot}
      WHITELIST=${lib.escapeShellArg whitelistFile}
      PKG=${lib.escapeShellArg pkg}
      TARGET=${lib.escapeShellArg home}

      [ -d "$STOW_ROOT" ] || exit 0
      [ -f "$WHITELIST" ] || exit 0

      ${rm} -rf -- "$PKG"
      ${mkdir} -p -- "$PKG"

      while IFS= read -r line; do
        line="$(${sed} -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' <<<"$line")"
        [ -z "$line" ] && continue
        case "$line" in \#*) continue ;; esac

        src="$STOW_ROOT/$line"

        if [ -d "$src" ]; then
          prefix="$STOW_ROOT/"
          while IFS= read -r -d $'\0' f; do
            rel="''${f#"$prefix"}"
            ${mkdir} -p -- "$PKG/$(${dirname} -- "$rel")"
            ${ln} -sfn -- "$f" "$PKG/$rel"
          done < <(${find} "$src" -type f -print0)
        elif [ -f "$src" ]; then
          ${mkdir} -p -- "$PKG/$(${dirname} -- "$line")"
          ${ln} -sfn -- "$src" "$PKG/$line"
        fi
      done < "$WHITELIST"

      cd "$STOW_ROOT"
      ${stow} --no-folding -R -d "$STOW_ROOT" -t "$TARGET" ".whitelist"
    '';
  in {
    config = {
      environment.systemPackages = [pkgs.stow];

      system.activationScripts.stowWhitelist = {
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
