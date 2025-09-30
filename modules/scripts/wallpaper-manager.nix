{
  config,
  lib,
  pkgs,
  ...
}: let
  # Reference the wallpapers from the home directory where they'll be copied
  wallpaperDir = "$HOME/.local/share/wallpapers";

  wallpaper-manager = pkgs.writeShellScriptBin "wallpaper-manager" ''
    #!/usr/bin/env bash

    WALLPAPER_DIR="${wallpaperDir}"
    STATE_FILE="$HOME/.config/current-wallpaper"

    case "$1" in
        "next"|"nextimg")
            # Get all wallpapers in sorted order for consistent cycling
            mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" \( -type f -o -type l \) \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.bmp" -o -iname "*.gif" \) | sort)

            if [ ''${#WALLPAPERS[@]} -eq 0 ]; then
                echo "No wallpapers found in $WALLPAPER_DIR"
                exit 1
            fi

            # Find current wallpaper index or start at 0
            CURRENT_INDEX=0
            if [ -f "$STATE_FILE" ]; then
                CURRENT_WALLPAPER=$(cat "$STATE_FILE")
                for i in "''${!WALLPAPERS[@]}"; do
                    if [ "''${WALLPAPERS[i]}" = "$CURRENT_WALLPAPER" ]; then
                        CURRENT_INDEX=$i
                        break
                    fi
                done
            fi

            # Get next wallpaper (cycle back to 0 if at end)
            NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ''${#WALLPAPERS[@]} ))
            WALLPAPER="''${WALLPAPERS[NEXT_INDEX]}"

            # Save current wallpaper to state file
            echo "$WALLPAPER" > "$STATE_FILE"

            # Set the wallpaper
            swww img "$WALLPAPER" --transition-type fade --transition-duration 1
            echo "Set wallpaper: $(basename "$WALLPAPER")"
            ;;

        "current"|"set")
            # Set wallpaper from state file
            if [ -f "$STATE_FILE" ]; then
                WALLPAPER=$(cat "$STATE_FILE")
                if [ -f "$WALLPAPER" ]; then
                    swww img "$WALLPAPER" --transition-type fade --transition-duration 1
                    echo "Set wallpaper: $(basename "$WALLPAPER")"
                else
                    echo "Wallpaper file not found: $WALLPAPER"
                    # Fallback to cycling to the next wallpaper
                    echo "Cycling to next wallpaper..."
                    exec "$0" next
                fi
            else
                echo "No wallpaper state file found. Starting wallpaper cycle..."
                exec "$0" next
            fi
            ;;

        *)
            echo "Usage: wallpaper-manager {next|current|set}"
            echo "  next    - Cycle to the next wallpaper"
            echo "  current - Set wallpaper from saved state"
            exit 1
            ;;
    esac
  '';
in {
  options.scripts.wallpaper-manager.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable wallpaper manager script with swww integration.";
  };

  config = lib.mkIf config.scripts.wallpaper-manager.enable {
    home.packages = [
      wallpaper-manager
    ];

    # Copy wallpapers to a known location in the home directory
    home.file.".local/share/wallpapers" = {
      source = ../../../media/wallpapers;
      recursive = true;
    };
  };
}
