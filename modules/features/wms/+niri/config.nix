{inputs, ...}: {
  flake.modules.nixos.niri = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (config.my) desktop-shells monitors cursor;
    inherit (lib.trivial) max;

    max-scale = builtins.foldl' max 1.0 (map (m: m.scale) monitors);

    launcherArgs = lib.concatMapStringsSep " " (arg: ''"${arg}"'') (lib.splitString " " desktop-shells.launcherCommand);

    scratchpad-binds = lib.optionalString config.my.wm.niri.use-scratchpads ''
      Mod+0 { toggle-workspace-visibility "stash"; }
      Mod+Shift+0 { toggle-workspace-visibility "work"; }
      Mod+Q            { spawn "niri-scratchpad" "create" "1" "--as-float"; }
      Mod+E            { spawn "niri-scratchpad" "create" "2" "--as-float"; }
      Mod+G            { spawn "niri-scratchpad" "create" "3" "--as-float"; }
      Mod+P            { spawn "niri-scratchpad" "create" "4" "--as-float"; }
      Mod+Ctrl+Q       { spawn "niri-scratchpad" "delete" "1"; }
      Mod+Ctrl+E       { spawn "niri-scratchpad" "delete" "2"; }
      Mod+Ctrl+G       { spawn "niri-scratchpad" "delete" "3"; }
      Mod+Ctrl+P       { spawn "niri-scratchpad" "delete" "4"; }
    '';

    monitorConfigs =
      map (monitor: ''
        output "${monitor.name}" {
          scale ${toString monitor.scale}
          mode "${toString monitor.dimensions.width}x${toString monitor.dimensions.height}@${toString monitor.refresh}"
          position x=${toString monitor.position.x} y=${toString monitor.position.y}
        }
      '')
      monitors;

    nix-settings = builtins.concatStringsSep "\n" ([
        ''
          xwayland-satellite {
            path "${lib.getExe pkgs.xwayland-satellite-unstable}"
          }

          cursor {
            xcursor-theme "${cursor.name}"
            xcursor-size ${toString cursor.size}
          }

          environment {
            QT_SCALE_FACTOR "${toString max-scale}"
          }
        ''
      ]
      ++ monitorConfigs
      ++ [
        (lib.optionalString (desktop-shells.name != "dank-shell") ''
          spawn-at-startup "${desktop-shells.execCommand}"
        '')
        (lib.optionalString config.my.wm.niri.use-scratchpads ''
          spawn-sh-at-startup "niri-scratchpad daemon"

          workspace "stash" {
              open-on-output "DP-1"
              hidden true
          }
          workspace "work" {
              open-on-output "DP-1"
              hidden true
          }
          workspace "test" {
              open-on-output "DP-1"
          }
        '')
        ''
          binds {
            Mod+Shift+G { spawn "kitty" "-T" "pamix" "${lib.getExe pkgs.pamix}"; }
            Mod+space { spawn ${launcherArgs}; }
            Mod+Ctrl+Shift+S { spawn "snip"; }
            ${scratchpad-binds}
          }
        ''
      ]);
  in {
    environment.systemPackages =
      lib.optional
      config.my.wm.niri.use-scratchpads
      inputs.niri-scratchpad.packages.${pkgs.system}.default;
    hj.files.".config/niri/nix.kdl".text = nix-settings;
  };
}
