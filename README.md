# 🐢🐢🐢🐢㊗️NixOS Config
- Big WiP but hopefully shouldn't change too much structurally.
- Not meant to be plugin for other people due to sops integration with login, although my hope is others can refer to this who are trying to get started with some of the things I do here.  

# Things I do
- Home Manager as a module.
- Flakes with flake parts pointing to outputs/default.nix
- Impermanence in system and home. Per module persistance so wm switches don't pollute user space.
- Sops dependent install process, bring your own keys, secrets
- Stylix, off by default, and opted in per WM option
- Default settings for each host is stored in [defaultsettings.nix](hosts/defaultSettings.nix)
- Desktop/Window Managers can be set in [nixos-configs.nix](outputs/nixos-configs.nix) per host.
  - ( this file also merges those default settings in with any available hosts/hostname/attrs.nix)
    - which then becomes settings, that I use all over my config for stuff like flakedir/fonts/host|user/name, etc. 
  - The actual switches effect both home manager and nixos configuration
    -  refer to [user/wms/default.nix](nixosModules/user/wms/default.nix) and [system/wms/default.nix](nixosModules/system/wms/default.nix) respectively
-  critical components ( if i don't have these i can't boot/sys won't function ) are setup under system/critical 

## Bonus Memes
- Dwl Option is a custom version of dwl im working on with scratchpad/opacity support
  -  maybe more in the future idk

## Important Files
- [Flake entrypoint](flake.nix)
- [NixosConfigurations & HM Module](outputs/nixos-configs.nix)

  
[<img src="media/icons/purple-logo.png"/>](Logo)
