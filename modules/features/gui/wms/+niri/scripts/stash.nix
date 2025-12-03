## CREDIT: https://github.com/YaLTeR/niri/discussions/329#discussioncomment-13378697
{inputs, ...}: {
  flake.modules.nixos.niri = {
    pkgs,
    lib,
    ...
  }: {
    my.wm.niri.settings = lib.mkAfter [
      ''
        workspace "stash" {
            open-on-output "DP-1"
        }
        window-rule {
          match title="s-"
          open-on-workspace "stash"
          open-floating true
          default-floating-position x=16 y=0 relative-to="left"
          default-column-width  { fixed 920; }
          default-window-height { fixed 920; } // ~80% of 1080
        }
      ''
    ];
    environment.systemPackages = [
      inputs.niri-scratchpad.packages.${pkgs.system}.default
      #(pkgs.writeShellScriptBin "niri-stash" ''
      #  if [[ -z "$1" ]]; then
      #    echo "no argument provided"
      #    exit 1
      #  fi

      #  STASH_WIN_NAME="$1"
      #  STASH_WSP_NAME="stash"

      #  # identifiers for window app_id or title
      #  declare -A "NAME"
      #  NAME["s-term"]="s-term"
      #  NAME["s-proc"]="s-proc"
      #  NAME["s-file"]="s-file"
      #  NAME["s-gfile"]="org.gnome.Nautilus"
      #  NAME["s-vesktop"]="vesktop"
      #  NAME["s-firefox"]="firefox-scratchpad"
      #  NAME["s-spotify"]="spotify"

      #  # commands to run for a given identifier
      #  declare -A "CMD"
      #  CMD["s-term"]="kitty -T s-term"
      #  CMD["s-proc"]="kitty -T s-proc --hold btop"
      #  CMD["s-file"]="kitty -T s-file --hold zsh -c yazi"
      #  CMD["s-gfile"]="nautilus"
      #  CMD["s-vesktop"]="vesktop"
      #  CMD["s-firefox"]="firefox --name=firefox-scratchpad --no-remote -P firefox-scratchpad"
      #  NAME["s-spotify"]="spotify"

      #  main() {

      #    create_stash_win_if_none "$1"

      #    STASH_WIN_ID=$(get_stash_win_id)
      #    STASH_WIN_IS_FOCUSED=$(get_stash_win_focused)
      #    ACTIVE_WSP_NAME=$(get_active_wsp_name)

      #    if [[ "$STASH_WIN_IS_FOCUSED" == "false" ]]; then
      #      niri msg action move-window-to-workspace --window-id "$STASH_WIN_ID" "$ACTIVE_WSP_NAME"
      #      niri msg action focus-window --id "$STASH_WIN_ID"
      #    else
      #      # --focus=false supposedly doesnt work yet, but PR is there
      #      # https://github.com/YaLTeR/niri/pull/1820
      #      niri msg action move-window-to-workspace --window-id "$STASH_WIN_ID" "$STASH_WSP_NAME" --focus=false

      #      # niri workspace reference includes double quotes for some reason?
      #      niri msg action focus-workspace "\"$ACTIVE_WSP_NAME\""
      #    fi
      #  }

      #  create_stash_win() {
      #    local cmd="''${CMD[$1]}"
      #    niri msg action spawn -- "sh" "-c" "$cmd"
      #    wait_until_win_exists "$(map_name_to_identifier "$1")"
      #  }

      #  map_name_to_identifier() {
      #    echo "''${NAME[$1]}"
      #  }

      #  create_stash_win_if_none() {
      #    [[ $(get_stash_win_info) == "null" ]] && create_stash_win "$1"
      #  }

      #  wait_until_win_exists() {
      #    while [[ $(get_win_info "$1") == "null" ]]; do
      #      echo "waiting for window: $1"
      #      sleep 0.1
      #    done

      #    # optional extra just to avoid headaches
      #    sleep 0.1
      #  }

      #  get_win_info() {
      #    # matches identifier against title or app_id
      #    # get first if multiple exists, useful for windows that cannot set title ie. nautilus
      #    niri msg -j windows | jq "map(select(.title==\"$1\" or .app_id==\"$1\" )) | first"
      #  }

      #  get_stash_win_info() {
      #    get_win_info "$(map_name_to_identifier "$STASH_WIN_NAME")"
      #  }

      #  get_stash_win_id() {
      #    get_stash_win_info | jq '.id'
      #  }

      #  get_stash_win_focused() {
      #    get_stash_win_info | jq '.is_focused'
      #  }

      #  get_active_wsp_name() {
      #    niri msg -j workspaces | jq -r '.[] | select(.is_focused).idx'
      #  }

      #  main "$@"
      #'')
    ];
  };
}
