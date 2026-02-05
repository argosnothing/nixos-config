# Hyprland Configuration

This directory contains the Hyprland window manager configuration for NixOS.

## Structure

The configuration is split into two parts:

### 1. Static Configuration (`hyprland.conf`)

This file contains all Hyprland configuration that doesn't require Nix interpolation:

- **General settings** - gaps, borders, layout
- **Input configuration** - keyboard, mouse, touchpad
- **Decoration** - opacity, shadows, blur effects
- **Animations** - bezier curves and animation settings
- **Layouts** - master/dwindle layout configuration
- **Keybindings** - all keyboard shortcuts and mouse bindings
- **Window rules** - window-specific behavior
- **Workspace rules** - workspace-specific settings
- **Plugin configuration** - hyprsplit and hyprscrolling settings

This file is copied as-is to `~/.config/hypr/hyprland.conf` and can be edited directly without rebuilding the NixOS configuration.

### 2. Nix-Generated Configuration (`hyprland.nix`)

This module generates `~/.config/hypr/hyprland-nix.conf` with configuration that requires Nix interpolation:

- **Monitor configuration** - dynamically generated from `config.my.monitors`
- **Environment variables** - cursor theme and size from `config.my.cursor`
- **Menu launcher** - from `config.my.desktop-shells.launcherCommand`
- **Exec-once commands** - startup commands with proper package paths
- **Plugin loading** - using environment variables set by Nix

This file is automatically regenerated on NixOS rebuild and should not be edited manually.

## Configuration Flow

1. `hyprland.conf` sources `~/.config/hypr/hyprland-nix.conf` at the top
2. Nix-generated configuration provides dynamic values (monitors, paths, etc.)
3. Static configuration provides all the user-configurable settings

## Editing Configuration

### To modify static settings (keybinds, animations, etc.):

Edit `hyprland.conf` directly and reload Hyprland with `hyprctl reload`

### To modify Nix-interpolated settings (monitors, cursor, etc.):

Edit the corresponding options in your NixOS configuration and rebuild:
- Monitors: `config.my.monitors`
- Cursor: `config.my.cursor`
- Desktop shell: `config.my.desktop-shells`

## Benefits of This Approach

1. **Fast iteration** - Edit keybinds and settings without rebuilding NixOS
2. **Declarative where needed** - Monitor and package paths are still managed by Nix
3. **Clear separation** - Easy to see what's static vs. dynamic
4. **Portability** - Static config can be copied to non-NixOS systems (with manual adjustments)