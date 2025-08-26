# NixOS Configuration Instructions

## Project Overview

This is a modular NixOS configuration supporting multiple hosts (desktop, laptop, p51) with different window managers and configurations. The design emphasizes simplicity while supporting diverse hardware and desktop environments.

### Architecture Philosophy
- **Flake-based**: Uses Nix flakes for input management and reproducible builds
- **Host-centric**: Each host manages its own specific configuration
- **Modular design**: Shared functionality lives in `nixosModules/` for reuse
- **Separation of concerns**: System vs user configurations are clearly separated

## Directory Structure

```
nixos-config/
├── flake.nix                    # Input definitions and system architecture
├── hosts/
│   ├── default.nix              # Orchestrates all host configurations
│   ├── configuration.nix        # Shared host options (currently minimal)
│   └── [hostname]/              # Individual host configurations (each folder = one host)
│       ├── default.nix          # Host-specific settings and module wiring
│       ├── configuration.nix    # NixOS system configuration
│       ├── home.nix            # Home Manager user configuration
│       ├── hardware-configuration.nix # Hardware-specific config
│       └── [host-specific.nix] # Optional host-specific modules
├── nixosModules/
│   ├── stylix-config.nix        # Global styling configuration
│   ├── system/                  # System-level modules
│   │   ├── apps/               # System-wide applications (Flatpak, etc.)
│   │   ├── misc/               # Fonts, keyd, remote tooling
│   │   ├── services/           # System services (D-Bus, PipeWire, greeters)
│   │   ├── wms/                # Window manager system configs
│   │   └── style/              # System-level theming
│   └── user/                   # User-level modules (home-manager)
│       ├── apps/               # User applications (terminal, firefox, vscode)
│       ├── style/              # User-level theming
│       └── wms/                # Window manager user configs
│           └── hyprland/       # Complete Hyprland setup
│               ├── config/     # Hyprland configuration modules
│               ├── waybar/     # Status bar configuration
│               ├── wofi/       # Application launcher
│               └── wallpaper/  # Wallpaper management
└── media/
    ├── wallpapers/              # Desktop wallpapers
    └── wallpaper-manager.sh     # Wallpaper management script
```

## Key Components

### Flake Configuration (`flake.nix`)
- **Inputs**: 
  - `nixpkgs` (25.05 stable) and `nixpkgs-unstable`
  - `home-manager` for user configuration management
  - `stylix` for consistent theming across applications
  - `hyprland` and related plugins for Wayland compositor
  - `swww` for wallpaper management
  - `nixos-grub-themes` for boot theming
  - `nix-flatpak` for Flatpak integration

### Host Configuration Pattern

Each directory within `hosts/` represents a specific host system. The naming convention is simple: the directory name becomes the hostname. Each host follows this consistent structure:

```
hosts/{hostname}/
├── default.nix              # Host-specific settings and module wiring
├── configuration.nix         # NixOS system configuration
├── home.nix                  # Home Manager user configuration
├── hardware-configuration.nix # Auto-generated hardware config
└── [optional host-specific modules] # Additional .nix files for specialized configs
```

The `hosts/default.nix` file merges all host configurations together, making each directory automatically discoverable as a buildable configuration.

#### Host Settings System
Default settings are defined in `hosts/default.nix` as `defaultSettings`. Each host's `default.nix` can override these defaults using Nix attribute merging (`defaultSettings // { overrides }`). Key settings include username, font configuration, theming preferences, and feature toggles like battery management and window manager selection.
```

### System Modules (`nixosModules/system/`)

The system modules follow a consistent pattern of defining options with `lib.mkOption` and conditional configuration with `lib.mkIf`. Many modules are automatically enabled, but some use feature toggles.

#### Module Architecture Pattern
- **Option definitions**: Each module defines its own enable option (e.g., `wms.hyprland.enable`)
- **Conditional configuration**: Uses `lib.mkIf` to only apply config when enabled
- **Dynamic enabling**: The `wms/default.nix` automatically enables the window manager specified in `settings.wm`
- **Default behaviors**: Most modules default to enabled (`default = true`) with opt-out capability

#### Applications (`apps/`)
- **Flatpak integration**: System-wide Flatpak support with custom remotes
  - Steam, Jagex Launcher, RuneLite preconfigured
  - 32-bit compatibility layers included
  - Uses `systemFlatpak.enable` option (defaults to true)

#### Miscellaneous (`misc/`)
- **Fonts**: Comprehensive Nerd Fonts collection
- **Keyd**: CapsLock → Ctrl/Esc mapping
- **Remote tooling**: Smart card (PIV/CAC) support with custom certificates

#### Services (`services/`)
- **D-Bus**: System message bus with dconf support
- **GNOME Keyring**: Credential management
- **PipeWire**: Modern audio system (replaces PulseAudio)
- **Greeters**: TUI login manager (tuigreet) for Hyprland

#### Window Managers (`wms/`)
- **Dynamic selection**: `wms/default.nix` automatically enables the WM specified by `settings.wm`
- **Hyprland**: Wayland compositor with full system requirements
  - Enables tuigreet greeter, XWayland support, GNOME keyring
  - Installs GTK themes and desktop portal requirements
  - Uses `wms.hyprland.enable` option
- **GNOME**: X11 fallback option with `wms.gnome.enable`
- **Extensible**: New WMs can be added by creating the module and setting `wm = "newwm"`

### User Modules (`nixosModules/user/`)

User modules follow the same option-based pattern but configure home-manager instead of NixOS system settings.

#### Applications (`apps/`)
- **Terminal**: Kitty (primary), Alacritty (secondary) with opacity
- **Firefox**: PIV/CAC smart card integration, default browser
  - Uses `firefox.enable` option for conditional configuration
- **VSCode**: Vim bindings, Nix development extensions
- **GTK**: Theme integration (currently minimal)
- **User Flatpak**: Uses `userFlatpak.enable` for user-level Flatpak support

#### Window Manager Configurations (`wms/`)
Similar to system WMs, user WMs are dynamically enabled via `settings.wm`:

##### Hyprland Configuration (`user/wms/hyprland/`)
- **Modular structure**: Split into logical components (config/, waybar/, wofi/, wallpaper/)
- **Option-based**: Uses `wms.hyprland.enable` for conditional activation
- **Navigation**: Alt-based keybindings (not Super key)
- **Workspaces**: 1-10 regular + special workspaces (q,w,e,s)
- **Features**: 
  - Window animations with easeOutQuint bezier curves
  - 5px gaps, 2px rounded corners, subtle shadows
  - Screen capture (Alt+Shift+S)
  - Floating window shortcuts
- **Components**:
  - **Waybar**: Top panel with workspaces, system stats, tray
  - **Wofi**: Application launcher
  - **Wallpaper manager**: Custom swww-based cycling
  - **Cursor theme**: Static configuration (dynamic cursors cause crashes)

### Theming System (Stylix)

Global theming through Stylix with:
- **Base16 color scheme**: Gruvbox Dark Hard (configurable per host)
- **Font management**: Separate mono, sans, serif font definitions
- **Application targeting**: Hyprland, Firefox, VSCode, Waybar
- **Polarity**: Dark theme preference

## Host-Specific Configurations

Rather than documenting specific hosts, any directory created within `hosts/` becomes a buildable host configuration. The modular design means:

- **Host directories** contain only the configuration specific to that machine
- **Shared functionality** lives in `nixosModules/` and is imported as needed  
- **Hardware differences** are handled through `hardware-configuration.nix` and host-specific settings
- **Software variations** are controlled via the `settings` attribute set in each host's `default.nix`

### Common Host Patterns

**Desktop/Workstation Pattern:**
- Higher performance kernel (Xanmod)
- NVIDIA or AMD graphics drivers
- Larger font sizes for desktop displays
- Full development and media applications

**Laptop Pattern:**
- Battery management enabled (`battery.enable = true`)
- Smaller font sizes for screen real estate
- Power optimization settings
- Touchpad and input device configuration

**Specialized Hardware:**
- Legacy driver support (older NVIDIA cards)
- Custom input device mappings
- Specific kernel modules or parameters

## Development Aliases

Built-in shell aliases for system management:
```bash
updatesystem    # sudo nixos-rebuild switch --flake ~/nixos-config/#hostname
updatehome      # home-manager switch --flake ~/nixos-config/#username@hostname
```

## Build and Deployment

### Initial Setup
1. Clone repository to `~/nixos-config`
2. Generate hardware configuration: `nixos-generate-config`
3. Copy `hardware-configuration.nix` to appropriate host directory
4. Build system: `sudo nixos-rebuild switch --flake .#hostname`
5. Apply home configuration: `home-manager switch --flake .#username@hostname`

### Adding New Host
1. Create directory: `hosts/newhostname/`
2. Copy template files from existing host that matches your use case
3. Modify `default.nix` with host-specific settings override
4. Update hardware configuration with `nixos-generate-config`
5. The host will be automatically available for building (no manual registration needed)

### Package Management
- **System packages**: Add to `environment.systemPackages` in host configuration
- **User packages**: Add to `home.packages` in host home.nix
- **Unfree packages**: Automatically allowed via `nixpkgs.config.allowUnfree = true`

## Known Issues & Workarounds

1. **SDDM + Hyprland**: Login timing can cause XDG portal crashes
   - **Solution**: Using tuigreet instead of SDDM
   
2. **Dynamic cursors**: Can cause Hyprland crashes during home-manager switches
   - **Workaround**: Static cursor configuration implemented

3. **Font rendering**: X11 apps need additional fontconfig for proper rendering
   - **Solution**: Custom fontconfig in Hyprland user module

4. **Flatpak integration**: Requires specific environment variables
   - **Solution**: XDG_DATA_DIRS configured in user flatpak module

## Extension Points

### Adding New Window Manager
The WM system is designed for easy extension:
1. Create `nixosModules/system/wms/newwm.nix` with system requirements
   - Define `wms.newwm.enable` option with `lib.mkOption`
   - Use `lib.mkIf config.wms.newwm.enable` for conditional config
2. Create `nixosModules/user/wms/newwm/` directory for user configuration
   - Follow the same option pattern as other WMs
3. Add both to their respective default.nix imports
4. Set `wm = "newwm"` in host settings - automatic enabling via `wms."${settings.wm}".enable`

### Custom Application Modules
The module system supports feature toggles and conditional configuration:
1. Create module in appropriate `nixosModules/*/apps/` directory
2. Define options using `lib.mkOption` with sensible defaults
3. Use `lib.mkIf config.optionName.enable` for conditional configuration
4. Add to default.nix imports in the respective directory
5. Support host-specific overrides through the settings system

### Module Option Patterns
Most modules follow this structure:
```nix
{
  options = {
    feature.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;  # or false, depending on module
      description = "Enable this feature.";
    };
  };
  config = lib.mkIf config.feature.enable {
    # configuration only applied when enabled
  };
}
```

### Theming Customization
1. Modify `stylixTheme` in host settings
2. Override font selections in host default.nix
3. Customize application-specific theming in user/style/

## Dependencies & Inputs

### Core Dependencies
- **NixOS 25.05**: Stable base system
- **Home Manager**: User environment management
- **Stylix**: Application theming

### Optional Features
- **Hyprland**: Wayland compositor (can be replaced)
- **Flatpak**: Sandboxed application support
- **Smart card tools**: PIV/CAC authentication
- **Gaming**: Steam, gaming-specific packages

## Security Considerations

- **Smart card integration**: DoD PKI certificates included
- **Polkit**: Privilege escalation management
- **Secure boot**: Not currently configured
- **Firewall**: Default NixOS firewall enabled

## Performance Optimizations

- **Xanmod kernel**: Low-latency kernel for desktop
- **PipeWire**: Modern audio with lower latency than PulseAudio  
- **Wayland**: Native Wayland for better performance than X11
- **NVIDIA optimizations**: Modesetting, DRM kernel modules

This configuration prioritizes modularity and maintainability while supporting diverse hardware configurations and desktop environments.
