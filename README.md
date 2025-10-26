# △ NixOS Config : DENDRITIC △
Non-dendritic configuration now lives on the #legacy branch. 
- Dendritic config based around import-tree and flake parts, with an emphasis on blurring the lines between home and system.
- If you are one of those mentioned in the credits here and don't want to be mentioned, just let me know.

# Things I do
- Dendritic pattern with modules folder being evaluated at flake level.
- Impermanence in system and home. Per module persistance so wm switches don't pollute user space.
- Sops dependent install process, bring your own keys, secrets.
- Coupled user/system modules, inspired by [saygo's](https://github.com/saygo-png/nixos) configuration.
- Some code here, such as the impermanence module is --stolen-- borrowed from [iynaix's](https://github.com/iynaix/dotfiles) config

## Important Files
- [Flake entrypoint](flake.nix)
- [nixosConfigurations.host entry point](modules/os-configs.nix)

# Credits
 For collectively dragging me, kicking and screaming, across multiple finish lines
- [Jet](https://github.com/Michael-C-Buckley/home-config)
- [Iynaix](https://github.com/iynaix/dotfiles)
- [Saygo](https://github.com/saygo-png/nixos)
- [Tony, BTW](https://www.tonybtw.com/)
- [Emzy](https://github.com/emzywastaken/dotfiles)

## Notes
I had briefly moved over to hjem, but have since decided it'd be best to stay on home manager for the time being. I will likely continue to use hjem in parts of my config as a simple file linker, with occasional use of its generator.
  
[<img src="media/icons/purple-logo.png"/>](Logo)
