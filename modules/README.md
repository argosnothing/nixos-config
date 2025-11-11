# Modules

### critical
* Important Utilities that need to be included in my configs, most tend to be under `modules.nixos.critical`
* Hosts will not need to import the critical module directly, this is handled through the `modules.nixos.base` bundle under the bundles directory
* Other important modules
  * `modules.nixos.grub`
  * `modules.nixos.uefi`
### features
* Top level dir of general features, apps, window managers, shell utilities, etc.
  * Window Managers/Desktops I support
    * Niri `modules.nixos.niri`
    * Mango `modules.nixos.mango`
    * oxwm `modules.nixos.oxwm`
    * Xfce `modules.nixos.xfce`
    * Cosmic `modules.nixos.cosmic`

### hardware
* Location for host specific utilities, these tend to be defined by `modules.nixos.hostname`
### options
* Options that the rest of the system can expect to always be present. `modules.nixos.options` and `flake.settings` for flake level options
### overlays
* I still don't really understand these. `flake.overlays.default`
### packages
* Derivations that I need to build as part of my system configuration.
### bundles
* Module bundles that act as system presets, or simply extended configuration on top of a window manager so it does not pollute my host module imports.
  * `modules.nixos.base`
    * Critically important stuff that each host should at least have (where `modules.nixos.critical` is imported)
  * `modules.nixos.niri-bundle`
    * Niri bundle of my current fav niri setup
### utility
* This is mostly just house keeping stuff, and meta related things like helper libraries.
### +hostname
* Where `modules.nixos.hostname` is declared and imports are added. 
### README.md
* You're reading it. 
### home.nix
* Not exactly what you might think, this does not live in home manager, but simply configures it and some other things. 
### nixosConfigurations.nix
* The system configurations for this flake. Every host will have an entry here. 
