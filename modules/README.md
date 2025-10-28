# Modules

## Critical
* Important Utilities that need to be included in my configs, most tend to be under `modules.nixos.critical`
* Other important modules
  * `modules.nixos.grub`
  * `modules.nixos.uefi`
## features
* Top level dir of general features, apps, window managers, shell utilities, etc.
## hardware
* Location for host specific utilities, these tend to be defined by `modules.nixos.hostname`
## options
* Options that the rest of the system can expect to always be present. `modules.nixos.options` and `flake.settings` for flake level options
## packages
* Derivations that I need to build as part of my system configuration.
## presets
* Module bundles that act as system presets.
  * `modules.nixos.base`
    * Critically important stuff that each host should at least have


