#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.local/share/wallpapers"
STATE_FILE="$HOME/.config/current-wallpaper"

case "$1" in
    "next"|"nextimg")
        # Pick a random wallpaper
        WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.bmp" -o -iname "*.gif" \) | shuf -n 1)
        
        if [ -z "$WALLPAPER" ]; then
            echo "No wallpapers found in $WALLPAPER_DIR"
            exit 1
        fi
        
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
                exit 1
            fi
        else
            echo "No wallpaper state file found. Run 'wallpaper-manager next' first."
            exit 1
        fi
        ;;
        
    *)
        echo "Usage: wallpaper-manager {next|current|set}"
        echo "  next    - Pick and set a random wallpaper"
        echo "  current - Set wallpaper from saved state"
        exit 1
        ;;
esac
