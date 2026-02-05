# Stow abomination.
# Similar to persist, but for stow packages.
# some modules might opt to do configuration through stow versus symlinking from store.
# Could be for any reason, maybe i want a new nvim config that i want to continuously work on
# this lets me do stuff like my.stow.directories = ["nvim"]; and it'll take from the .dot folder
# in my flake for that directory and stow it out.
# If im doing persistance ill still need to persist the target directory so it doesn't get deleted
{
  flake.modules.nixos.stow = {
    pkgs,
    lib,
    config,
    ...
  }: let
    user = config.my.username;
    home = "/home/${user}";

    host = config.my.hostname;
    repo = "${home}/nixos-config";
    stowRoot = "${repo}/.dot";

    pkgsList = config.my.stow.directories or [];
    pkgsFile = pkgs.writeText "stow-packages" (lib.concatStringsSep "\n" pkgsList + "\n");

    runuser = "${pkgs.util-linux}/bin/runuser";
    stow = "${pkgs.stow}/bin/stow";
    mkdir = "${pkgs.coreutils}/bin/mkdir";
    sort = "${pkgs.coreutils}/bin/sort";
    comm = "${pkgs.coreutils}/bin/comm";
    cat = "${pkgs.coreutils}/bin/cat";
    mktemp = "${pkgs.coreutils}/bin/mktemp";
    rm = "${pkgs.coreutils}/bin/rm";
    awk = "${pkgs.gawk}/bin/awk";

    script = pkgs.writeShellScript "apply-stow-packages" ''
      set -euo pipefail

      HOME=${lib.escapeShellArg home}
      ROOT=${lib.escapeShellArg stowRoot}
      LIST=${lib.escapeShellArg pkgsFile}
      STATE="$ROOT/.stow-packages.state.${lib.escapeShellArg host}"

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

      cd "$ROOT"

      while IFS= read -r pkg; do
        [ -z "$pkg" ] && continue
        ${stow} --no-folding -D -d "$ROOT" -t "$HOME" "$pkg" || true
      done < "$drop"

      while IFS= read -r pkg; do
        [ -z "$pkg" ] && continue
        [ -d "$ROOT/$pkg" ] || continue
        ${stow} --no-folding -R -d "$ROOT" -t "$HOME" "$pkg"
      done < "$cur"

      ${cat} -- "$cur" > "$STATE"
      ${rm} -f -- "$cur" "$prev" "$drop"
    '';
  in {
    config = {
      environment.systemPackages = [pkgs.stow];
      system.activationScripts.stowPackages = {
        supportsDryActivation = true;
        text = ''
          ${runuser} -u ${lib.escapeShellArg user} -- \
            env HOME=${lib.escapeShellArg home} \
            ${lib.escapeShellArg script}
        '';
      };
      systemd.services.stow-packages = {
        description = "Re-stow whitelisted packages into home";
        wantedBy = ["multi-user.target"];
        after = ["local-fs.target" "systemd-user-session.service"];
        serviceConfig = {
          Type = "oneshot";
          User = user;
          Environment = ["HOME=${home}"];
          ExecStart = script;
        };
      };
    };
  };
}
