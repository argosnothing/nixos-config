{
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
            # Pick a random wallpaper from the nix-managed wallpapers
            WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.bmp" -o -iname "*.gif" \) | shuf -n 1)
            
            if [ -z "$WALLPAPER" ]; then
                echo "No wallpapers found in $WALLPAPER_DIR"
                exit 1
            fi
            
            # Save current wallpaper to state file
            echo "$WALLPAPER" > "$STATE_FILE"
            
            # Set the wallpaper
            ${pkgs.swww}/bin/swww img "$WALLPAPER" --transition-type fade --transition-duration 1
            echo "Set wallpaper: $(basename "$WALLPAPER")"
            ;;
            
        "current"|"set")
            # Set wallpaper from state file
            if [ -f "$STATE_FILE" ]; then
                WALLPAPER=$(cat "$STATE_FILE")
                if [ -f "$WALLPAPER" ]; then
                    ${pkgs.swww}/bin/swww img "$WALLPAPER" --transition-type fade --transition-duration 1
                    echo "Set wallpaper: $(basename "$WALLPAPER")"
                else
                    echo "Wallpaper file not found: $WALLPAPER"
                    # Fallback to a random wallpaper if the saved one doesn't exist
                    echo "Selecting a new random wallpaper..."
                    exec "$0" next
                fi
            else
                echo "No wallpaper state file found. Selecting a random wallpaper..."
                exec "$0" next
            fi
            ;;
            
        *)
            echo "Usage: wallpaper-manager {next|current|set}"
            echo "  next    - Pick and set a random wallpaper"
            echo "  current - Set wallpaper from saved state"
            exit 1
            ;;
    esac
  '';
in {
  home.packages = [
    wallpaper-manager
    pkgs.swww
  ];
  
  # Copy wallpapers to a known location in the home directory
  home.file.".local/share/wallpapers" = {
    source = ../../../../../media/wallpapers;
    recursive = true;
  };
}
